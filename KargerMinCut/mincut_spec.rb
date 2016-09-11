require 'rspec'
require_relative 'mincut'

create_test_file = ->(ary, fname='text.txt') {
  tfile = File.open fname, 'w'
  ary.each do |e|
    tfile.puts e.join(',')
  end
  tfile.close
}

RSpec.describe MinCut do
  describe '::create_alist_from_file' do
    it 'returns a peroperly formatted aList' do
      alist = MinCut.create_alist_from_file('test_one.txt')
      expect(alist).to be_a Array
      expect(alist[0]).to be_a Array
    end
    it 'reads in the simplest aList' do
      alist = MinCut.create_alist_from_file('test_one.txt')
      expect(alist).to eql [[1,2],[2,1]]
    end
    it 'the proc creates a simple test_file' do
      input = [ [1,2], [2,1]]
      create_test_file.call(input, 'test_one.txt')
    end
  end
  describe 'Basic setup' do
    it 'fails for empty adjacency list' do
      expect{
        MinCut.new []
      }.to raise_error('Adjacency list is too small')
    end
    it 'fails for too-small adjacency list' do
      expect{
       MinCut.new [[1,2,3]]
      }.to raise_error('Adjacency list is too small')
    end
  end
end
