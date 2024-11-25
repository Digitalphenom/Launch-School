=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  Given an input number along with a possible set of numbers, return the total sum of multiples of 3 or 5 if a range of numbers is not provided or multiples of the provided range.

    ▣ explicit requriements
      □ multiples should be less than the input number
         17 => 3 + 6 + 9 + 12 + 15 (18) > 17 thus not included
         1 => 0 = 0
      □ return total sum of all multiples generated
      □ create a to class method
      □ create a to instance method

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄


#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

Input : Integer or set of integers
  creating multiples of numbers stored in an array
Output: single integer that represents a sum

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  ▣ Define a class method named to
    □ this method will be used for instances where a secondary multiples numbers is not provided so we use 3 & 5 as multiples
    □ generate multiples of 3 & 5 upto but less than the input number
    □ access each number and add it
  
  ▣ Define instance method to
    □ store provided multiples in an array
    □ expose & access each multiple
      □ generate of multiple of each number upto but less than the input number
      □ add all numbers

  3 + 6 + 9 + 12 == 10

  ▣ return total
=end

class SumOfMultiples
  def initialize(*range)
    @range = range
  end

  def self.to(limit)
    SumOfMultiples.new.sum_values(limit)
  end

  def to(limit)
    sum_values(limit, @range)
  end

  def sum_values(limit, range = [3, 5])
    range.each_with_object([]) do |num, arr|
      num.step(limit, num) do |step|
        break if step >= limit
        arr << step
      end
    end.uniq.sum
  end
end

def sum_of_values(lismit, range)


#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞
#class SumOfMul
#
#  def self.to(limit)
#    range = [3, 5]
#    obj = SumOfMul.new
#    sum = 0
#    
#    range.each do |step|
#      sum += obj.sum_of_val(limit, step)
#    end
#    sum
#  end
#
#  def sum_of_val(limit, step)
#    arr = []
#
#    step.step(limit, step) do |multiple|
#      break if multiple >= limit
#      arr << multiple
#    end
#    arr.sum
#  end
#end
#
#p SumOfMul.to(10)

 #◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞


# class SumOfMultiples
#   def initialize(*range)
#     @range = range
#     @multiples_arr = []
#   end
# 
#   def self.to(num)
#     SumOfMultiples.new.sum_values(num)
#   end
# 
#   def to(num)
#     sum_values(num, @range)
#   end
# 
#   def sum_values(limit, range = [3, 5])
#     counter = 0
# 
#     range.each do |multiple|
#       (limit / multiple).times do |_|
#         counter += multiple
#         @multiples_arr << counter if counter < limit
#       end
#       counter = 0
#     end
#     @multiples_arr.uniq.sum
#   end
# end