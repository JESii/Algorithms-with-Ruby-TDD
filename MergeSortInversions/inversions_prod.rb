require_relative 'inversions'

input_data = File.open('integerArray.txt').readlines
puts "input data. class: #{input_data.class}; size: #{input_data.size}"
# input_data.each_with_index do |int, idx|
#   puts "i: #{int}"
#   break if idx > 10
# end
inversions = Inversions.new(input_data)
inversions.sort
puts "inversions: #{inversions.inversions}"
