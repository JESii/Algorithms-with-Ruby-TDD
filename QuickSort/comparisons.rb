require 'pry'

class Comparisons
  def initialize(input_array, pivot = 'last_element_swap', debug = false)
    @input_array = input_array.clone
    @input_array_same = input_array
    @comparisons = 0
    @pivot = pivot
    $debug = debug
  end

  def sort
    case @pivot
    when 'first_element_jes'
      # First attempt; moves the pivot at each comparison
      _partition_first_element_jes(@input_array, 0)
    when 'first_element'
      # Moves the pivot at the end of a partitioning
      # Allocates a new array at each partition
      _partition_first_element(@input_array)
    when 'last_element_end'
      # Takes the pivot from the end of the array
      # and leaves the pivot at the end
      # Uses the same array with pointers
      _partition_last_element_end(@input_array_same, 0, @input_array_same.size - 1)
    when 'last_element_swap'
      # Uses last element as pivot
      # and swaps it into the first position
      # Same array with pointers
      _partition_last_element_swap(@input_array_same, 0, @input_array_same.size - 1)
    when 'median_element_swap'
      # Uses median-of-three element as pivot
      # and swaps it into the first position
      # Same array with pointers
      _partition_median_element_swap(@input_array_same, 0, @input_array_same.size - 1)
    else
      fail "Invalid partition option: #{@pivot}"
    end
  end

  def comparisons
    @comparisons
  end

  def _swap_median(ary, ldx, rdx)
    # 2-element arrays are aberrant: no middle element
    puts "_swap_median:  #{ldx}, #{rdx} / #{ary}" if $debug
    return ary[ldx] if rdx - ldx <= 1
    left =[ ary[ldx], ldx]
    right = [ary[rdx], rdx]
    # mid_ndx = ((rdx - ldx)/2)   ### WRONG! when ldx > 0!!!
    mid_ndx = ldx + ((rdx - ldx)/2)
    middle = [ary[mid_ndx], mid_ndx]
    wkary = [left, middle, right].sort
    puts "_swap_median: mid_ndx: #{mid_ndx}, wkary: #{wkary}" if $debug
    # Return median of median: [value, location]
    wkary[1]
  end

  def _partition_median_element_swap(ary, ldx, rdx)

    puts "median_swap: #{ldx}, #{rdx} / #{ary.slice(ldx-2..ldx+2)} - #{ary.slice(rdx-2..rdx+2)}" if $debug

    # Handle the base case
    return if rdx <= ldx
    @comparisons += rdx - ldx
    if (rdx - ldx) == 1
      if ary[ldx] > ary[rdx]
        ary[ldx], ary[rdx] = ary[rdx], ary[ldx]
        puts "median_swapBaseSwap: #{ldx}, #{rdx} - #{ary[ldx]}, #{ary[rdx]}" if $debug
      end
      return
    end
    # Now handle partitioning off median-of-three element
    # Swap pivot into first element
    median = _swap_median(ary, ldx, rdx)[1]
    ary[ldx], ary[median] = ary[median], ary[ldx]
    puts "median_swap-swapped: l-#{ldx}, m-#{median}, r-#{rdx} / #{ary.slice(ldx-2..ldx+2)} - #{ary.slice(rdx-2..rdx+2)}" if $debug

    p = ary[ldx]
    i = ldx+1
    (ldx+1..rdx).each do |j|
      if p > ary[j]
        ary[i], ary[j] = ary[j], ary[i]
        i += 1
      end
    end

    puts "median_swap-finishedScan: l-#{ldx}, m-#{median}, r-#{rdx} /#{i} / #{ary.slice(ldx-2..ldx+2)} - #{ary.slice(rdx-2..rdx+2)}" if $debug
    # Move the pivot to its proper location
    ary[ldx], ary[i-1] = ary[i-1], ary[ldx]
    puts "median_swap-pivotMoved: #{ldx}, #{rdx} / #{ary.slice(ldx-2..ldx+2)} - #{ary.slice(rdx-2..rdx+2)}" if $debug
    pivot_point = i-2
    [_partition_median_element_swap(ary, ldx, pivot_point), _partition_median_element_swap(ary, i, rdx)]
  end

  def _partition(ary, ldx, rdx)
    #NOTE: Not ready yet, but should be the base partitioning routine when refactored
    puts "partition: #{ldx}, #{rdx} / #{ary.slice(ldx-2..ldx+2)} - #{ary.slice(rdx-2..rdx+2)}" if $debug
    # Handle the base case
    return if rdx <= ldx
    @comparisons += rdx - ldx
    if (rdx - ldx) == 1
      if ary[ldx] > ary[rdx]
        ary[ldx], ary[rdx] = ary[rdx], ary[ldx]
      end
      return
    end
    # Now handle partitioning off the last element
    # Swap pivot into first element
    ary[ldx], ary[rdx] = ary[rdx], ary[ldx]
    puts "partition-swapped: #{ldx}, #{rdx} / #{ary.slice(ldx-2..ldx+2)} - #{ary.slice(rdx-2..rdx+2)}" if $debug
    p = ary[ldx]
    i = ldx+1
    (ldx+1..rdx).each do |j|
      if p > ary[j]
        ary[i], ary[j] = ary[j], ary[i]
        i += 1
      end
    end
    puts "partition-finishedScan: #{i} / #{ary.slice(ldx-2..ldx+2)} - #{ary.slice(rdx-2..rdx+2)}" if $debug
    # Move the pivot to its proper location
    ary[ldx], ary[i-1] = ary[i-1], ary[ldx]
  end

  def _partition_last_element_swap(ary, ldx, rdx)

    puts "Last_swap: #{ldx}, #{rdx} / #{ary.slice(ldx-2..ldx+2)} - #{ary.slice(rdx-2..rdx+2)}" if $debug
    # Handle the base case
    return if rdx <= ldx
    @comparisons += rdx - ldx
    if (rdx - ldx) == 1
      if ary[ldx] > ary[rdx]
        ary[ldx], ary[rdx] = ary[rdx], ary[ldx]
      end
      return
    end
    # Now handle partitioning off the last element
    # Swap pivot into first element
    ary[ldx], ary[rdx] = ary[rdx], ary[ldx]
    puts "Last_swap-swapped: #{ldx}, #{rdx} / #{ary.slice(ldx-2..ldx+2)} - #{ary.slice(rdx-2..rdx+2)}" if $debug
    p = ary[ldx]
    i = ldx+1
    (ldx+1..rdx).each do |j|
      if p > ary[j]
        ary[i], ary[j] = ary[j], ary[i]
        i += 1
      end
    end
    puts "Last_swap-finishedScan: #{i} / #{ary.slice(ldx-2..ldx+2)} - #{ary.slice(rdx-2..rdx+2)}" if $debug

    # Move the pivot to its proper location
    ary[ldx], ary[i-1] = ary[i-1], ary[ldx]
    puts "Last_swap-pivotMoved: #{ldx}, #{rdx} / #{ary.slice(ldx-2..ldx+2)} - #{ary.slice(rdx-2..rdx+2)}" if $debug

    #NOTE: Following code added when debugging for stack overflow
    if (i-2) > ldx && i < rdx
    puts "Calling _partition(ary, #{ldx}, #{i-2}), _partition(ary, #{i}, #{rdx})" if $debug
    [_partition_last_element_swap(ary, ldx, i-2), _partition_last_element_swap(ary, i, rdx)]
    elsif (i-2) > ldx
    puts "Calling _partition(ary, #{ldx}, #{i-2})" if $debug
    [_partition_last_element_swap(ary, ldx, i-2)]
    elsif i < rdx
    puts "Calling _partition(ary, #{i}, #{rdx})" if $debug
    [ _partition_last_element_swap(ary, i, rdx)]
    end
    return
  end

  def _partition_last_element_end(ary, ldx, rdx)

    # Handle the base case
    return if rdx <= ldx
    @comparisons += rdx - ldx
    if (rdx - ldx) == 1
      if ary[ldx] > ary[rdx]
        ary[ldx], ary[rdx] = ary[rdx], ary[ldx]
      end
      return
    end
    # Now handle partitioning off the last element
    p = ary[rdx]
    i = ldx
    i += 1 if ary[ldx] < p
    (ldx+1..rdx).each do |j|
      if ary[j] < p
        ary[i], ary[j] = ary[j], ary[i]
        i += 1
      end
    end
    ary[rdx], ary[i] = ary[i], ary[rdx]
    [_partition_last_element_end(ary, ldx, i-1), _partition_last_element_end(ary, i+1, rdx)]
    return
  end

  def _partition_first_element(ary)
    return ary if ary.size <= 1
    @comparisons += ary.size - 1
    if ary.size == 2
      if ary[0] > ary[1]
        return [ary[1], ary[0]]
      else
        return ary
      end
    end
    px = ary[0]
    i =  1
    (1..ary.size-1).each do |j|
      if(px > ary[j])
        ary[j], ary[i] = ary[i], ary[j]
        i += 1
      end
    end
    # Move pivot element into its rightful place
    ary[0], ary[i-1] = ary[i-1], ary[0]
    return [_partition_first_element(ary.slice(0, i-1)).flatten, ary[i-1], _partition_first_element(ary.slice(i, ary.size-1).flatten)].flatten
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
