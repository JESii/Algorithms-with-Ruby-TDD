require 'rspec'
require_relative 'mincut'

RSpec.describe MinCut do
  describe 'MinCut::create_alist_from_file' do
    it 'reads in an a list' do
      alist = MinCut.create_alist_from_file('test1.txt')
      expect(alist).to be_a AList
    end
  end
  describe 'Basic setup' do
    it 'fails for too-small adjacency list' do
      mc = MinCut.new []
      expect(mc).to be_a MinCut
    end
  end
end
