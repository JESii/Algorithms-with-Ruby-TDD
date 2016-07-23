require 'rspec'
require_relative 'comparisons'

RSpec.describe Comparisons do
  describe '#sort with pivot = first-element' do
    it 'handles the base case' do
      ta = [1]
      sorting = Comparisons.new(ta)
      expect(sorting.sort).to eql ta
    end
    it 'handles a sorted array' do
      ta = [1, 2]
      sorting = Comparisons.new(ta)
      expect(sorting.sort).to eql ta
    end
    it 'sorts a tiny, sorted array' do
      ta = [2, 1]
      sorting = Comparisons.new(ta)
      expect(sorting.sort). to eql ta.sort
    end
    it 'sorts a 4-element array', :current => true do
      ta = [3, 4, 2, 1]
      sorting = Comparisons.new(ta)
      expect(sorting.sort).to eql ta.sort
    end
  end
end
