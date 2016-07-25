require_relative 'comparisons'

ta = []
File.open('courseraQuickSort.txt') do |f|
  f.readlines.each do |line|
    ta << line.to_i
  end
end
puts "size of input array = #{ta.size}"
# first_element_jes
binding.pry if ta.size <= 0
comparisons = Comparisons.new(ta, 'first_element_jes')
comparisons.sort
result = comparisons.comparisons
puts "'first_element_jes' comparisons = #{result}"
# first_element
comparisons = Comparisons.new(ta, 'first_element')
comparisons.sort
result = comparisons.comparisons
puts "'first_element' comparisons = #{result}"
