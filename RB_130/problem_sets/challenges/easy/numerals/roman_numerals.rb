

=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
# Given a integer as an input convert it into its Roman numeral equivlaent.

  ▣ You must subtract at the correct indication
    □ Placing a larger number before a smaller is considred subtraction

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
I = 1     
V = 5     IV = 4
X = 10    IX = 9
L = 50    XL = 40
C = 100   XC = 90
D = 500   CD = 400
M = 1000  CM = 900

1 + 4 = 5 ( 5 x 1)
5 + 4 = 10 (5 x 2)
10 + 40 = 50 (5 x 10)
50 + 50 = 100 (5 x 20)
100 + 400 = 500 ( 5 x 100)
500 + 500 = 1000 (5 x 200)

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
Input: Integer

Return: String Numeral

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  ▣ Create a RomanNumberal Class
    □ A constructor method should initialize an input and captured it.
  ▣ Define a to_roman method
  ▣ Create a hash lookup table of positive integers and their addition & subtraction Roman equivalents


  ▣ Convert input number into an array composed of Roman integer equivalents
    □ Until all elements are roman integers divide it by the highest possible roman equivalent. If it already is roman return self.
    □ Until input number is 0 divide by highest possible roman integer equivalent and populate new array with the roman equivalent x the times its divisble by.

      □ Divide input number by highest possible roman integer equivlent.
        57 / 50 = 1
      □ Append 50 into new array the number of times it is divisible by
        [50] <= 1X
      □ Subtract 57 by the roman integer equivalent X the times its divisble by.
        57 - 50 = 7
      □ Repeat
        7 / 5 = 1
        [50, 5] << 5
        [L, V] << CONVERSION[5]
        7 - 5 = 2
        2 / 1 = 2
        [50, 5, 1, 1] << 1 x 2 times
        2 - 2 = 0
      57 = [50, 7] => [50, 5, 1, 1]
      17 = [10, 7] => [10, 5, 1, 1]

      22 / 10 = 2
      XX << 2 x conversion
      22 - 10 + 10 = 2
      2 / 1 = 2
      XXII << 2 x conversion
      2 - 2 = 0

      39 / 10 = 3
      XXX << conversion
      30 - 30 = 9
      9 match roman integer equivalent?
        if match append match
      XXX << IX
      XXXIX
      9 - 9 = 0
      0
       = [20, 2] => [20, 1, 1]

      6 = [6] => [5, 1]
      27 => [20, 7] => [10, 10, 5, 1, 1]
      257 => [200, 50, 7] => [100, 100, 50, 5, 1, 1]

  ▣ Access each element in array and convert to its roman equivalent leveraging the pre-made roman lookup table to find and return a match.

  ▣ Convert Array into a string return

  ▣ Check if input number matches roman hash table if match append match and subtract input by match.
    □ else
      Divide input number by highest roman integer equivalent
      Append Roman num the times it is divisible by to string
      subtract roman integer from input
      repeat until input number is 0
  ▣ return string

=end

class RomanNumeral
  def initialize(input)
    @input = input
    @roman_numerals = ''
  end

  def self.look_up
    { 1 => 'I', 10 => 'X', 4 => 'IV', 9 => 'IX',
      40 => 'XL', 5 => 'V', 50 => 'L', 90 => 'XC', 400 => 'CD',
      500 => 'D', 1000 => 'M', 100 => 'C', 900 => 'CM',
    }.to_a.sort_by { |sub_arr| sub_arr.first }
  end

  def to_roman
    input_number = @input

    RomanNumeral.look_up.reverse_each do |divisor, numeral|
      quotient = input_number / divisor
      next if quotient.zero?
  
      quotient.times { @roman_numerals << numeral }
      input_number -= (divisor * quotient)
    end
    @roman_numerals
  end
end




















