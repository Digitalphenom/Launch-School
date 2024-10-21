=begin
 #⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
Write some code that converts modern decimal numbers into their Roman number equivalents.

  ▣ requirements
     roman numerals are represented by 
     I => 1
     V => 5 => 4 = IV
     X => 10 => 9 = IX
     L => 50 => 40 XL
     C => 100 => 90 => XC
     D => 500 => 400 => CD
     M => 1,000 => 900 = CM

  ▣ implicit req
     must account for subtraction ie
     - How to account for numbers that subtract?
     - *placing a smaller number infront of a larger number indicates subtraction ie
      4 => IV
      9 => IX
      this sequence repeats for numbers upto 30
      14 => XIV
      19 => XIX
      24 => XXIV
      29 => XXIX
      34 => XXXIV
      39 => XXXIX
      40 => XL
      44 => XLIV
      90 => XC

    create a negative number lookup table
    negative numbers include subtracted number from main numeral
    4 => IV
    9 => IX
    14 => XIV
    40 => XL
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
4 => IV
9 (5, 1, 1, 1, 1) => IX
27 (10, 10, 5, 1, 1) XXVII

19 (10, 9)

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

Input: int

intermediary: (convert int into compo parts starting from largest roman numeral)
27 [10, 10, 7]
  27 - 10 => [10]
  17 - 10 => [10, 10]
  7 - 5 => [10, 10, 5]
  2 - 1 => [10, 10, 5, 1]
  1 - 1 => [10, 10, 5, 1, 1]

   [10, 10, 5, 1, 1]
   [X, X, V, I, I]

9 [5, 4]
  [V, IV]

14 [10, 4]
   [X, IV]

34 [10, 10, 10, 4]
   [X,X,X, IV]

   check for existing match if none break num down n repeat until all nums are matched
40 []
Output: roman numeral equivalent => XXVII


#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

 ▣ create RomanNumeral class
 □ define constructor
    -should accept a int arg
    - capture in iv
 ▣ create numeral lookuptable

 ▣ define to_roman im
 ▣ compare input number with r table
  □ if not match break down digits
    - break down digits from largest possible roman numeral
     ﹥ sequence [1000, 500, 100, 50, 10, 5, 1]
     ﹥ compare digit with each num and check if disibile. if true
     subtract digit from inputdigit and repeat until no more digits can be divisble
=end

class RomanNumeral
  attr_reader :digit, :result

  NUMERAL_LOOKUP = {
    "I" => 1,
    "IV" => 4,
    "V" => 5,
    "IX" => 9,
    "X" => 10,
    "XL" => 40,
    "L" => 50,
    "XC" => 90,
    "C" => 100,
    "CD" => 400,
    "D" => 500,
    "CM" => 900,
    "M" => 1000,
  }

  def initialize(digit)
    @digit = digit
    @result = ''
  end

  def to_roman
    until digit <= 0
      self.digit = destructure_digit(digit)
    end
    result
  end

  private

  def destructure_digit(digit)
    sequence = NUMERAL_LOOKUP.sort_by { |key, value| value}

    sequence.reverse_each do |numeral, key|
      next unless (digit / key) >= 1

      (digit / key).times do
        self.result += numeral
        digit -= key
      end
      break
    end
    digit
  end

  attr_writer :digit, :result
end
