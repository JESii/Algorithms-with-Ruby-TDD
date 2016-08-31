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
      puts "Option: first_element_jes"
      puts "file array: #{ta}"
      sorting = Comparisons.new(ta)
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
  ['last_element_swap', 'last_element_end'].each do |lopt|
    puts "Testing for #{lopt}"
    describe 'sort with pivot last-element', :last_element => true do
      before do
        @lopt = lopt
      end
      it 'recognizes the last-element option' do
        last = Comparisons.new([], @lopt)
        expect(last).to_not be_nil
      end
      it 'sorts a simple 2-element sorted array' do
        ary = [1,2]
        last = Comparisons.new(ary, @lopt)
        last.sort
        expect(ary).to eql [1,2]
      end
      it 'sorts a 2-element array' do
        ary = [2,1]
        # puts "objid: #{ary.object_id}"
        Comparisons.new(ary, @lopt).sort
        # puts "objid: #{ary.object_id}"
        expect(ary).to eql [1,2]
      end
      it 'sorts a 4-element array' do
        ary = [1,3,4,2]
        Comparisons.new(ary, @lopt).sort
        expect(ary).to eql [1,2,3,4]
      end
      it 'sorts another 4-element array' do
        ary = [3,1,4,2]
        Comparisons.new(ary, @lopt).sort
        expect(ary).to eql [1,2,3,4]
      end
      it 'sorts a 10-element array' do
        ary = [7,4,13,99,71,3,11,8,9,10]
        last = Comparisons.new(ary, @lopt)
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
        sorting = Comparisons.new(ta,@lopt)
        sorting.sort
        expect(ta).to eql ta.sort
        puts "comparisons: #{sorting.comparisons}"
      end
    end
  end
end
