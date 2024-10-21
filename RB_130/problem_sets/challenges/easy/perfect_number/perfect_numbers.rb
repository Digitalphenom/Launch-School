=begin
##⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  Write a method that returns the category of a given numbers Aliquot sum.

  - An Aliquot Sum is simply the total sum of the numbers that can be evenly divisisble in a given number

    ▣ Explicit Requirments
      □ return the string 
        ﹥ Perfect (Sum == Number)
        ﹥ Abundant (Sum > Number)
        ﹥ Deficient (Sum < Number)
      □ Self should be excluded from division

Perfect numbers have an Aliquot sum that is equal to the original number.
Abundant numbers have an Aliquot sum that is greater than the original number.
Deficient numbers have an Aliquot sum that is less than the original number.

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

input:6 
evenly divisible by 1, 2, 3
Aliquot Sum 1 + 2 + 3 = 6
6 == 6 = Perfect
‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
15 is a deficient number since its divisors are 1, 3, and 5 and 1 + 3 + 5 = 9 which is less than 15.
24 is an abundant number since its divisors are 1, 2, 3, 4, 6, 8, and 12 and 1 + 2 + 3 + 4 + 6 + 8 + 12 = 36 which is greater than 24.
Prime numbers 7, 13, etc. are always deficient since their only divisor is 1.
‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
Input: Integer
 Could use an accumulator to increment total values
Output: String

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  ▣ Define a class named PerfectNumber
  ▣ Define a class method classify that takes a single input number
    □ If input number is less than 0 return a standardError
    □ Determine how many times a given number is evenly divisible by inputnumber
      ﹥ begin from 1 upto the input number minus 1
          6 ( 6 / 5) (6/4) (6/3) (6/2)(6/1)
          All numbers that are evenly divisible should be added 
          *NOT the quotient.
  ▣ Compare accumulator with input number
    □ if even return Perfect
    □ less tahn deficient
    □ grater than abundant    
=end

class PerfectNumber

  def self.classify(input_number)
    raise StandardError if input_number < 1

    return 'perfect' if aliquot_sum(input_number) == input_number
    return 'abundant' if aliquot_sum(input_number) > input_number
    return 'deficient'
  end

  class << self

    private

    def aliquot_sum(number)
      (1...number).reduce do |acc, divisor|
       number % divisor == 0 ? acc += divisor : acc
    end
  end
end
