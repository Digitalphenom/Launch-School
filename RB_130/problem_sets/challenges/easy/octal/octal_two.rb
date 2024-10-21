=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
create a octal to decimal conversion program that accepts an octal input str and returns a decimal output.

  ▣ explicit requirements
    □ valid octal numbers are 0, 1, 2, 3, 4, 5, 6, and 7.
    □ invalid input as octal 0

  
    □ start from right most number and move left


#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

The rightmost digit gets multiplied by 80 = 1
The next digit gets multiplied by 81 = 8
The digit after that gets multiplied by 82 = 64
The digit after that gets multiplied by 83 = 512
...
The n*th* digit gets multiplied by 8n-1.

233 # octal
332
3*8^0 + 3*8^1 + 2*8^2

= 2*8^2 + 3*8^1 + 
= 2*64  + 3*8   + 3*1
= 128   + 24    + 3
= 155


 11
 1*(8**0) = 1
 1*(8**1) = 8
 9

 Octal.new('11')

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
input: string
  intermediary:
   get input length
   from 0 upto length (**8(length))
   then mult by current number
   add total
   return
output: integer

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

▣ create Octal class
  □ accept a input str in constructor
▣ create to_decimal imethod
  □ return 0 if invalid
    - input includes 8,9 or any char outside of valid

  □ get length of input
  □ reverse input string
    - access current char
    - get current index
  □ multiply to power [acces current input](8**current index)
    - this should return an agregated array of values
    - get the sum
=end

class Octal
  attr_reader :input

  VALID = %w(0 1 2 3 4 5 6 7)

  def initialize(input)
    @input = input
  end

  def to_decimal
    return 0 if input.match?(/[^0-7]/)
    result = []

    input.chars.reverse_each.with_index do |char, i|
      result << (char.to_i * (8**i))
    end
    result.sum
  end
end

p Octal.new('2047').to_decimal