class MinCut

  def initialize(alist)
    fail "Adjacency List is not an array" if alist.class != Array
    fail "Adjacency list is too small" if alist.size <= 1
    @alist = alist
    @nlist = []
    @nlist = alist.map { |e| e[0] }
    size = alist.size
    @pcount = (size * (size - 1) * Math.log(size) / 2).to_i
    @pval = size * size
    puts "@pcount : #{@pcount}, @pval : #{@pval}"
  end

  def self.debug(debug = true)
    $debug = debug
  end

  def self.create_alist_from_file(fname)
    alist = []
    nlist = []
    File.open(fname) do |f|
      f.readlines.each do |line|
        nodelist = (line.chomp.split(' ').map { |e| e.to_i })
        alist << nodelist
        nlist << nodelist[0]
      end
    end
    alist
  end

  # This method runs multiple iterations of karger's MinCut algorithm
  def p_cut
    puts "Starting values pcount: #{@pcount}"
    srand
    #Save the initialized values for multiple calls
    $alist = @alist.clone
    $nlist = @nlist.clone
    $pval= @pval
    @pcount.times do |p|
      @alist = $alist.clone
      @nlist = $nlist.clone
      srand
      binding.pry
      pval = cut
      puts "@pval: #{@pval} / pval: #{pval}"
      @pval = pval if pval < @pval
    end
    @pcount
  end

  # This routine runs a single iteration of Karger's MinCut algorithm
  def cut
    # base case
    if @alist.size == 2
      binding.pry if @alist[0].size <= 1 || @alist[0].size != @alist[1].size
      return (@alist[0].size - 1 + @alist[1].size - 1)/2
    end

    puts "START: @nlist: #{@nlist}, @alist: #{@alist}" if $debug
    # Select two random, connected nodes
    nindex = rand(@nlist.size)
    nitem = @nlist.at(nindex)
    nconnect = @alist[nindex].slice(1, @alist[nindex].size-1)
    # nconnect.delete_at 0      # Remove the node number
    # Remember that we retain 'duplicate' edges to maintain the correct edge count
    # So remove any duplicate retained edges so as not to bias the random selection
    nconnect.uniq!
    tindex = rand(nconnect.size)
    citem = nconnect.at(tindex)
    # puts "nconnect: #{nconnect} / tindex: #{tindex}, titem: #{titem}" if $debug
    # It's OK that there are duplicated edges here; 'first' one is fine
    cindex = @nlist.index(citem)
    puts "Collapsing node #{citem} => #{nitem}" if $debug
    # Collapse the two nodes into a single node
    # Get all adjacent elements from both nodes
    begin
    ta = @alist[nindex].slice(1, @alist.size-1) + @alist[cindex].slice(1, @alist.size-1)
    rescue
      binding.pry
    end
    puts "wip-adj/1: #{ta}" if $debug
    # Delete any references to either node : self-loops
    begin
    ta.delete_if { |e| e == nitem || e == citem }
    rescue
      binding.pry
    end
    puts "wip-adj/2: #{ta}" if $debug
    # Now put the remaining node number back in as the 'owner'
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
