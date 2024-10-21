=begin

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
given a natural number and a set f one or more other numbers, find the sum of all the multiple of the numbers in the set that are less than the first number

  ▣ Explicit req
    □ accept a natural number argument
    □ should accept another set of values 
      - if no other number is provided default to 3-5
    □ should find all multiples of set less than the initial input natural number

  ▣ Implicit req
    □ define to class method & instance methods
      ﹥ accepts natural number
    □ constructor method accepts set of multiples
      ﹥ set can be of 2 or more
    □ sequence should start from the set of multiples
      3 upto but less than input number
      5 upto but less than input number
    
  
Natural Numbers are positive numbers excluding 0 or < 0
 #⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄


input: 20
default 3 or 5
3, 5, 6, 9, 10, 12, 15, and 18.
The sum of these multiples is 78.
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
input: 1
default 3 & 5
output 0
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
input: 10
default 3-5
3 6 9
5 
output: 23
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

input: int

  intermediary: 
  generate sequence starting from default nums or specified set
  should be less than input
  sum total

output: sum of numbers int

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  ▣ Create SumTest class
  ▣ create to class method
    □ accept natural number
  ▣ create constructor method
   □ accept a variable number of arguments
    ﹥ set default to [3 & 5]
   □ capture in array

  ▣ generate sequence of multiples
    □ access each number
     create sequence from number upto but less than input number
     set a start range from multiple to n

   □ generate sequence interchangeably
    grab maximum number for each multiple & divide by set
    20 / 3 = 6
    20 / 5 = 4
    max length = 10

    generate a sequence from 0 upto max length
     specify upto length
     break if current multiple is >= n
      access first multiple and place in result
       - increment by multiple
       access second multiple and place in result
       - increment by multiple
       - add to result
      repeat 
    end

    # the edge case in this problem based on how I wrote it is that multiples should be unique and not contain duplicates.
=end
class SumOfMultiples
  attr_reader :set, :sequence

  def self.to(n)
    SumOfMultiples.new(3, 5).to(n)
  end

  def initialize(*set)
    @set = set
  end

  def to(n)
    set.each_with_object([]) do |multiple, arr|
      (multiple).step(n , multiple ) do |current_multiple|
        break if current_multiple >= n
        arr << current_multiple unless arr.include?(current_multiple)
      end
    end.sum
  end
end


