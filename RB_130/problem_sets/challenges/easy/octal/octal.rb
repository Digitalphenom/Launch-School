

=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
  Given an input octal number, convert it into its decimal equivalent.

    ▣ Explicit Requirements
      □ Invalid inputs return 0
        □ Octals that contains non numeric chars or non valid octals are invalid.
      □ valid octal digits are: 
          (0, 1, 2, 3, 4, 5, 6, and 7.)
      □ Right most digit is multiplied by 0 upto before the nth* number 3
      □ *nth* numbers are multiplied by its position minuts 1 (5*4-1)

##⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄



#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄


  Input: string
  can use an accumulator to get the calculation 

  Output: Integer

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algo◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  ▣ Access octal and check if it is valid
    □ if it contains chars that are not 0-7 return 0
  ▣ Convert Octal into workable digits
    □ seperate and place in array
      ﹥ 11 = [1, 1]
  ▣ calculate each digit begining with the right most
    □ calcualtion should multiply current digit with base 8 followed by power of current index position thus => [5, 1] => 1*8**0 => 5*8**1 
      ﹥ If index position is *nth* 4-7 then subtract 1.
    □ Then add all values together
  ▣ return total sum 

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Code ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
=end

class Octal
  attr_reader :octal

  def initialize(octal)
    @octal = octal
  end
  
  def to_decimal
    return 0 if octal.match?(/[^0-7]/)

    arr = octal.to_i.digits

    arr.each_with_index.reduce(0) do |acc, (num, i)|
      acc + num * 8 ** i
    end 
  end
end
