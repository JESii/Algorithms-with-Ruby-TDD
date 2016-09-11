require 'rspec'
require_relative 'mincut'

RSpec.describe MinCut do
  describe '::create_alist_from_file' do
    it 'reads in an a list' do
      alist = MinCut.create_alist_from_file('test1.txt')
      expect(alist).to be_a Array
      expect(alist[0]).to be_a Array
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
