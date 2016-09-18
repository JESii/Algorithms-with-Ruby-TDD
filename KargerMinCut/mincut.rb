class MinCut

  def initialize(alist)
    fail "Adjacency List is not an array" if alist.class != Array
    fail "Adjacency list is too small" if alist.size <= 1
    @alist = alist
    @nlist = []
    @nlist = alist.map { |e| e[0] }
  end

  def self.debug(debug = true)
    $debug = debug
  end

  def self.create_alist_from_file(fname)
    alist = []
    nlist = []
    File.open(fname) do |f|
      f.readlines.each do |line|
        nodelist = (line.chomp.split(',').map { |e| e.to_i })
        alist << nodelist
        nlist << nodelist[0]
      end
    end
    [nlist, alist]
  end

  def cut
    # base case
    if @alist.size == 2
      return @alist[0].size - 1
    end

    puts "START: @nlist: #{@nlist}, @alist: #{@alist}" if $debug
    # Select two random, connected nodes
    nindex = rand(@nlist.size)
    nitem = @nlist.at(nindex)
    nconnect = @alist[nindex].clone
    nconnect.delete_at 0      # Remove the node number
    # Remember that we retain 'duplicate' edges to maintain the correct edge count
    # So remove any duplicate retained edges so as not to bias the random selection
    nconnect.uniq!
    tindex = rand(nconnect.size)
    citem = nconnect.at(tindex)
    # puts "nconnect: #{nconnect} / tindex: #{tindex}, titem: #{titem}" if $debug
    # It's OK that there are duplicated edges here; 'first' one is fine
    cindex = @nlist.index(citem)
    puts "Collapsing node #{citem} => #{nitem}"
    # Collapse the two nodes into a single node
    # Get all adjacent elements from both nodes
    ta = @alist[nindex].slice(1, @alist.size-1) + @alist[cindex].slice(1, @alist.size-1)
    puts "wip-adj/1: #{ta}" if $debug
    # Delete any references to either node
    ta.delete_if { |e| e == nitem || e == citem }
    puts "wip-adj/2: #{ta}" if $debug
    # Now put the remaining node number back in
    ta.unshift nitem
    puts "wip-adj/3: #{ta}" if $debug
    # Delete the collapsed node from the node list and the adjacency list
    @alist[nindex] = ta
    @alist.delete_at cindex
    @nlist.delete_at cindex
    # Now replace all collapsed node numbers with the remaining node number
    @alist.each_with_index do |e,i|
      e.each_with_index do |n,j|
        @alist[i][j] = nitem if @alist[i][j] == citem
      end
      # @alist[i].uniq!
    end
    puts "END: @nlist: #{@nlist}, @alist: #{@alist}" if $debug
    cut
  end
end
