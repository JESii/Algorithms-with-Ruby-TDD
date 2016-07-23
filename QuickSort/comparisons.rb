require 'pry'

class Comparisons
  def initialize(input_array, pivot = 'first_element')
    @input_array = input_array.clone
    puts "input: #{@input_array}" unless @input_array.size > 25
    case pivot
    when 'first_element'
      @pivot = 'pivot_first_element'
    end

  end

  def sort
    _sort(@input_array, @pivot)
  end

  def _sort(ary, pivot)
    puts "_sort: pivot: #{pivot}; ary: #{ary}"
    return [] if ary.nil? || ary.empty?
    return ary if ary.size == 1
    if ary.size == 2
      if ary[0] > ary[1]
        return [ary[1], ary[0]]
      else
        return ary
      end
    end
    px = public_send(pivot, ary)
    # puts "starting ary: #{ary}"
    ary.each_index do |i|
      next if i == 0
      # puts "loop ary: #{ary}"
      # binding.pry
      if ary[px] > ary[i]
        tmp = ary.delete_at i
        # puts "tmp: #{tmp}"
        ary.insert(px, tmp)
        # puts "ary: #{ary}"
        ary[px] = tmp
        px += 1
        # puts "ary: #{ary}; px: #{px}"
      end
    end
      # binding.pry
      puts "recursing: px: #{px}; array: #{ary}; Lslice: #{px == 0 ? [] : ary.slice(0..px-1)}; Rslice: #{ary.slice(px..-1)}"
      lslice = px == 0 ? [] : ary.slice(0..px-1)
      rslice = ary.slice(px..ary.size-1)
      puts "results: Lslice - #{lslice}; Rslice - #{rslice}"
      return [_sort(lslice, pivot), _sort(rslice, pivot)].flatten
  end

  def pivot_first_element(ary)
    0
  end
end
