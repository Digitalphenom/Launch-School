=begin
# this exercise appears to challenge the reader to uncover what a set is by looking at the test cases.

# They define a set as unique elements that can be manipulated in several well defined ways.

# all elements of a set will be numbers
  ▣ Implicit Req
    Set will receive values in array

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

    set = CustomSet.new([1])
    assert_equal false, set.empty?

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
When a new instance is created and accepts a set it comes in the form of values within an array

input: []
output: Customset instance

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

▣ create a customset class
  □ store sets in set iv

▣ define empty im
  ﹥ retrieves set =>[1] in form of array
  ﹥ invoke Array#empty method

▣ define Contains im
  ﹥ requires an argument
  ﹥ checks if the set includes the corresponding value

▣ define subset im
  ﹥ requires a Set instances argument
  ﹥ retrieves set
    □ compares set
      ﹥ retrive sets & compare
        if both empty return true
        if self empty & other not empty => true
        if self non empty & other empty => false

        if subset equal return true
        if self includes all values in other true else false

▣ define disjoin im
  ﹥

▣ define intersection method
  the Intersection method requires an instance argument and returns a set of all matches (sorted) as an object.
  exist[3,2,5] => arg[2, 5] => new[2, 5]
    □ access each element in existing set and check for matches in argument set
      □ if there are any matches, place in new set, sort and return
      □ if no matches return empty array
        ﹥ if arg set is empty return empty set
        ﹥ vascuos truth
          ﹥ if incoming set is empty return

=end

class CustomSet
  attr_reader :set

  def initialize(set = [])
    @set = set
  end

  def add(ele)
    @set << ele unless @set.include?(ele)
    self
  end

  def empty?
    set.empty?
  end

  def contains?(value)
    set.include?(value)
  end

  def subset?(other)
    set.all? { |ele| other.set.include?(ele) }
  end

  def disjoint?(other)
    set.none? { |ele| other.set.include?(ele) }
  end

  def eql?(other)
    set.uniq.sort.eql?(other.set.sort)
  end

  def ==(other)
    set == other.set
  end

  def intersection(other)
    set.select! { |ele| other.set.include?(ele) }
    self
  end

  def difference(other)
    set.reject! { |ele| other.set.include?(ele) }
    self
  end

  def union(other)
    other.set.each { |ele| add(ele) }
    set.sort!
    self
  end
end

set = CustomSet.new([1, 2, 3])
set.subset?(CustomSet.new([4, 1, 3]))
