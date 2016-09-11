class MinCut
  def initialize(alist)
    fail "Adjacency List is not an array" if alist.class != Array
    fail "Adjacency list is too small" if alist.size <= 1
    @alist = alist
  end
  def self.create_alist_from_file(fname)
    return [[]]

  end
end
