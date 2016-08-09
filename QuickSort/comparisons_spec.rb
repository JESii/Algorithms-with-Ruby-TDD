require 'rspec'
require_relative 'comparisons'

RSpec.describe Comparisons do
  describe '#sort with pivot = first_element_jes' do
    it 'handles the base case' do
      ta = [1]
      sorting = Comparisons.new(ta)
      expect(sorting.sort).to eql ta
      expect(sorting.comparisons).to eql 0
    end
    it 'handles a sorted array' do
      ta = [1, 2]
      sorting = Comparisons.new(ta)
      expect(sorting.sort).to eql ta
      expect(sorting.comparisons).to eql 1
    end
    it 'sorts a tiny, sorted array' do
      ta = [2, 1]
      sorting = Comparisons.new(ta)
      expect(sorting.sort). to eql ta.sort
      expect(sorting.comparisons).to eql 1
    end
    it 'sorts a 4-element array' do
      ta = [3, 4, 2, 1]
      sorting = Comparisons.new(ta)
      expect(sorting.sort).to eql ta.sort
      expect(sorting.comparisons).to eql 4
    end
    it 'sorts a 7-element array' do
      ta = [7,9,3,4,17,1,6]
      sorting = Comparisons.new(ta)
      expect(sorting.sort).to eql ta.sort
      expect(sorting.comparisons).to eql 11
    end
    it 'sorts many elements from a file', :current => true do
      ta = []
      File.open('quickSort.test') do |f|
        counter = 0
        f.readlines.each do |line|
          ta << line.to_i
          counter += 1
          break if counter > 25
        end
      end
      puts "file array: #{ta}"
      sorting = Comparisons.new(ta)
      expect(sorting.sort).to eql ta.sort
    end
  end
  describe 'sort with pivot = first_element', :case => 'first_element'  do
    it 'handles the base case' do
      ta = [1]
      sorting = Comparisons.new(ta,'first_element')
      expect(sorting.sort).to eql ta
      expect(sorting.comparisons).to eql 0
    end
    it 'handles a sorted array' do
      ta = [1, 2]
      sorting = Comparisons.new(ta,'first_element')
      expect(sorting.sort).to eql ta
      expect(sorting.comparisons).to eql 1
    end
    it 'sorts a tiny, sorted array' do
      ta = [2, 1]
      sorting = Comparisons.new(ta,'first_element')
      expect(sorting.sort). to eql ta.sort
      expect(sorting.comparisons).to eql 1
    end
    it 'sorts a 4-element array', :current => true do
      ta = [3, 4, 2, 1]
      sorting = Comparisons.new(ta,'first_element')
      expect(sorting.sort).to eql ta.sort
      expect(sorting.comparisons).to eql 4
    end
    it 'sorts a 7-element array' do
      ta = [7,9,3,4,17,1,6]
      sorting = Comparisons.new(ta,'first_element')
      expect(sorting.sort).to eql ta.sort
      expect(sorting.comparisons).to eql 13
    end
    it 'sorts many elements from a file', :current => true do
      ta = []
      File.open('quickSort.test') do |f|
        counter = 0
        f.readlines.each do |line|
          ta << line.to_i
          counter += 1
          break if counter > 25
        end
      end
      puts "file array: #{ta}"
      sorting = Comparisons.new(ta,'first_element')
      expect(sorting.sort).to eql ta.sort
    end
  end
  describe 'sort with pivot last-element', :last_element => true do
    lopt = 'last-element'
    if 'recognizes the last-element option' do
      ary = [1,2]
      last = Comparisons.net(lopt)
      expect(last).to.not be_nil
    end
  end
end
