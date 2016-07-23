class Comparisons
  def initialize(input_array, pivot = 'first_element')
    @input_array = input_array
    case pivot
    when 'first_element'
      @pivot = 'pivot_first_element'
    end

  end

  def sort
    _sort(@input_array, @pivot)
  end

  def _sort(ary, pivot)
    return ary if ary.size == 1
    px = public_send(pivot, ary)
    ary.each_with_index do |e, i|
      next if i == 0
      if ary[px] > ary[i]
        tmp = ary.delete_at i
        ary.insert(px, tmp)
        ary[px] = tmp
        px += 1
      end
    end
    ary
  end

  def pivot_first_element(ary)
    0
  end
end
