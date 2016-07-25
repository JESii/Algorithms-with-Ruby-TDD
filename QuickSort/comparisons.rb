require 'pry'

class Comparisons
  def initialize(input_array, pivot = 'first_element_jes')
    @input_array = input_array.clone
    puts "pivot: #{pivot}; size: #{@input_array.size}; input: #{@input_array[0..25]}#{@input_array.size > 25 ? '...': ''}"
    @comparisons = 0
    @pivot = pivot
  end

  def sort
    case @pivot
    when 'first_element_jes'
      # First attempt; moves the pivot at each comparison
      _partition_first_element_jes(@input_array, 0)
    when 'first_element'
      # Moves the pivot at the end of a partitioning
      _partition_first_element(@input_array, 0, 0)
    else
      fail "Invalid partition option: #{@pivot}"
    end
  end

  def comparisons
    @comparisons
  end

  def _partition_first_element(ary, ldx, rdx)
    return ary if ary.size <= 1
    @comparisons += ary.size - 1
    if ary.size == 2
      if ary[0] > ary[1]
        return [ary[1], ary[0]]
      else
        return ary
      end
    end
    px = ary[ldx]
    i = ldx + 1
    (ldx+1..ary.size-1).each do |j|
      if(px > ary[j])
        ary[j], ary[i] = ary[i], ary[j]
        i += 1
      end
    end
    ary[ldx], ary[i-1] = ary[i-1], ary[ldx]
    return [_partition_first_element(ary.slice(0, i-1), 0, 0).flatten, ary[i-1], _partition_first_element(ary.slice(i, ary.size-1).flatten, 0, 0)].flatten
  end

  def _partition_first_element_jes(ary, pivot)
    return [] if ary.nil? || ary.empty?
    return ary if ary.size == 1
    @comparisons += ary.size - 1
    if ary.size == 2
      if ary[0] > ary[1]
        return [ary[1], ary[0]]
      else
        return ary
      end
    end
    px =  pivot
    ary.each_index do |i|
      next if i == 0
      if ary[px] > ary[i]
        tmp = ary.delete_at i
        ary.insert(px, tmp)
        ary[px] = tmp
        px += 1
      end
    end
    # since pivot is in proper location, exclude it from partitions...
    lslice = px == 0 ? [] : ary.slice(0..px-1)
    rslice = ary.slice(px+1..ary.size-1)
    # ... and just include it as part of the returned array
    return [_partition_first_element_jes(lslice, pivot), ary[px], _partition_first_element_jes(rslice, pivot)].flatten
  end

end
