require 'rspec'
require_relative 'mincut'

create_test_file = ->(ary, fname='text.txt') {
  tfile = File.open fname, 'w'
  ary.each do |e|
    tfile.puts e.join(' ')
  end
  tfile.close
}

RSpec.describe MinCut do
  describe '::create_alist_from_file' do
    it 'returns a peroperly formatted aList' do
      alist = MinCut.create_alist_from_file('test_one.txt')
      expect(alist).to be_a Array
      expect(alist[0]).to be_an Array
    end
    it 'reads in the simplest aList' do
      alist = MinCut.create_alist_from_file('test_one.txt')
      expect(alist).to eql [[1,2],[2,1]]
    end
    it 'the proc creates a simple test_file' do
      input = [ [1,2], [2,1]]
      create_test_file.call(input, 'test1.txt')
    end
    it 'creates a more complicated test file' do
      input = [ [1,2,3], [2,1,3], [3,1,2]]
      create_test_file.call(input, 'test2.txt')
      alist = MinCut.create_alist_from_file('test2.txt')
      expect(input).to eql alist
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
  describe 'handles simple graphs' do
    before do
      MinCut.debug
    end
    it 'cuts a 2-node graph' do
      alist = MinCut.create_alist_from_file('test_one.txt')
      mincut = MinCut.new(alist)
      cut = mincut.cut
      expect(cut).to eql 1
    end
    it 'cuts a 3-node graph' do
      create_test_file.call([ [1,2,3], [2,1,3], [3,1,2] ], 'test.txt')
      alist = MinCut.create_alist_from_file('test.txt')
      puts "alist: #{alist}"
      mincut = MinCut.new(alist)
      cut = mincut.cut
      expect(cut).to eql 2
    end
    it 'cuts a 3-node tree' do
      MinCut.debug
      create_test_file.call([ [1,4], [2,4], [3,4], [4,1,2,3] ], 'test.txt')
      alist = MinCut.create_alist_from_file('test.txt')
      puts "alist: #{alist}"
      mincut = MinCut.new(alist)
      cut = mincut.cut
      expect(cut).to eql 1
    end
  end
  describe 'handles larger graphs' do
    it 'cuts a 5-node cycle' do
      MinCut.debug(true)
      cycle5 = [[1,2,5],[2,3,1],[3,4,2],[4,5,3],[5,1,4]]
      create_test_file.call(cycle5, 'test.txt')
      alist = MinCut.create_alist_from_file('test.txt')
      puts "alist: #{alist}"
      mincut = MinCut.new(alist)
      cut = mincut.cut
      expect(cut).to eql 2
    end
  end
end
