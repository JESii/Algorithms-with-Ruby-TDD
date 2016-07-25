require_relative 'inversions'

input_data = File.open('integerArray.txt').readlines
puts "input data. class: #{input_data.class}; size: #{input_data.size}"
inversions = Inversions.new(input_data)
inversions.sort
puts "inversions: #{inversions.inversions}"
