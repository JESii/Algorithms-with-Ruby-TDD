require 'rspec'
require_relative 'comparisons'

RSpec.describe Comparisons do
  describe '#sort with pivot = first_element_jes' do
    it 'handles the base case' do
      ta = [1]
      sorting = Comparisons.new(ta,'first_element_jes')
      expect(sorting.sort).to eql ta
      expect(sorting.comparisons).to eql 0
    end
    it 'handles a sorted array' do
      ta = [1, 2]
      sorting = Comparisons.new(ta,'first_element_jes')
      expect(sorting.sort).to eql ta
      expect(sorting.comparisons).to eql 1
    end
    it 'sorts a tiny, sorted array' do
      ta = [2, 1]
      sorting = Comparisons.new(ta,'first_element_jes')
      expect(sorting.sort). to eql ta.sort
      expect(sorting.comparisons).to eql 1
    end
    it 'sorts a 4-element array' do
      ta = [3, 4, 2, 1]
      sorting = Comparisons.new(ta,'first_element_jes')
      expect(sorting.sort).to eql ta.sort
      expect(sorting.comparisons).to eql 4
    end
    it 'sorts a 7-element array' do
      ta = [7,9,3,4,17,1,6]
      sorting = Comparisons.new(ta,'first_element_jes')
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
      puts "Option: first_element_jes"
      puts "file array: #{ta}"
      sorting = Comparisons.new(ta,'first_element_jes')
      expect(sorting.sort).to eql ta.sort
    end
  end
  describe 'sort with pivot = first_elerent', :case => 'first_element'  do
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
      puts "Option: first_element"
      puts "file array: #{ta}"
      sorting = Comparisons.new(ta,'first_element')
      expect(sorting.sort).to eql ta.sort
      puts "comparisons: #{sorting.comparisons}"
    end
  end
  describe '_swap_median' do
    puts 'testing _swap_median method'
    before do
      @comp = Comparisons.new([5,6,7,8,9], 'first_element', true)
    end
    it 'handles a 2-element array' do
      expect(@comp._swap_median([1,2], 0, 1)).to eql 1
    end
    it 'handles an odd-sized array' do
      expect(@comp._swap_median([1,3,2], 0, 2)).to eql [2,2]
    end
    it 'handles a even-sized array' do
      expect(@comp._swap_median([1,15,7,3,16,4], 0, 5)).to eql [4,5]
    end
    it 'handles a larger odd-sized array' do
      expect(@comp._swap_median([1,15,99,7,3,16,4], 0, 6)).to eql [4,6]
    end
    it 'handles a larger even-sized array' do
      expect(@comp._swap_median([1,15,99,7,17,3,16,14], 0, 7)).to eql [7,3]
    end
    it 'handles a third even-sized array' do
      expect(@comp._swap_median([1,15,7,99,97,3,16,108], 0, 7)).to eql [99, 3]
    end
    it 'handles a third odd-sized array' do
      expect(@comp._swap_median([1,15,7,99,109,97,3,16,108], 0, 8)).to eql [108, 8]
    end
    it 'handles a third odd-sized array with internal values' do
      expect(@comp._swap_median([1,15,7,99,109,97,16,3,108], 5, 8)).to eql [97,5]
    end
  end
  ['median_element_swap', 'last_element_swap', 'last_element_end'].each do |lopt|
    puts "Testing for #{lopt}"
    describe 'sort with pivot last-element', :last_element => true do
      before do
        @lopt = lopt
        @debug = true
      end
      it 'recognizes the last-element option' do
        last = Comparisons.new([], @lopt, @debug)
        expect(last).to_not be_nil
      end
      it 'sorts a simple 2-element sorted array' do
        ary = [1,2]
        last = Comparisons.new(ary, @lopt, @debug)
        last.sort
        expect(ary).to eql [1,2]
      end
      it 'sorts a 2-element array' do
        ary = [2,1]
        Comparisons.new(ary, @lopt, @debug).sort
        expect(ary).to eql [1,2]
      end
      it 'sorts a 4-element array' do
        ary = [1,3,4,2]
        Comparisons.new(ary, @lopt, @debug).sort
        expect(ary).to eql [1,2,3,4]
      end
      it 'sorts another 4-element array' do
        ary = [3,1,4,2]
        Comparisons.new(ary, @lopt, @debug).sort
        expect(ary).to eql [1,2,3,4]
      end
      it 'sorts a 10-element array' do
        ary = [7,4,13,99,71,3,11,8,9,10]
        last = Comparisons.new(ary, @lopt, @debug)
        last.sort
        expect(ary).to eql [3,4,7,8,9,10,11,13,71,99]
        puts "comparisons for #{@lopt}: #{last.comparisons}"
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
        puts "Option: #{@lopt}"
        puts "file array: #{ta.slice(1,5)} - #{ta.slice(ta.size-5, ta.size)}, id: #{ta.object_id}"
        sorting = Comparisons.new(ta,@lopt, @debug)
        sorting.sort
        expect(ta).to eql ta.sort
        puts "comparisons: #{sorting.comparisons}"
      end
    end
  end
end
