=begin
# given an input alpha char, return a diamond shape where the input letter is the midway point of the diamond and the top half of the diamon descend to the first alpha chars. The bottom half should repeat the top in reverse order.

▣ Explicit Requirements
  The first row contains one 'A'.
  The last row contains one 'A'.
  All rows, except the first and last, have exactly two identical letters.
  The diamond is horizontally symmetric.
  The diamond is vertically symmetric.
  The diamond has a square shape (width equals height).
  The letters form a diamond shape.
  The top half has the letters in ascending order.
  The bottom half has the letters in descending order.
  The four corners (containing the spaces) are triangles.

▣ Implicit Requirements
  □ include required spaces to form diamond
  □ spaces should be omited from input char
  □ add one left-outer space to each subsequent char 
  □ add one  right-outer space to each subsequent char 
  □ inner spaces follows the same logic in reverse
    □ add one space after the first/last alpha chars down to the input char

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

(    )A(    )4 0
(   )B( )B(   )3 1
(  )C(   )C(  )2 2
( )D(     )D( )1 3
()E(       )E()0 4
( )D(     )D( )1 3
(  )C(   )C(  )2 2
(   )B( )B(   )3 1
(    )A(    )4 0

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

Input: String Alpha char
=> white chars + alpha chars beginning with input char down to first alpha char

Output: alpha char diamon string

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algo ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

▣ Generate a sequence of chars from 'A' upto input string alphachar 
▣ Count left white chars should equal size of alpha sequence.
▣ Count right white chars should equal size of alpha sequence.
▣ count inner white chars should be in reverse 
  □ first char 0 down to size of collection 4 in (A-E)

▣ if inner char is 0 or 1 increment by 1
    else increment by 2
=end

class Diamond
  def self.make_diamond(char)
    top = generate_half_diamond(char)
    bottom = generate_half_diamond(char).reverse[1..-1]

    top.join + bottom.join
  end  

  class << self
    private
  
    def generate_half_diamond(input_char)
      sequence = ('A'..input_char).to_a
      outer = sequence.size
      inner = -1

      sequence.map do |char|
        outer -= 1
        inner += (inner > 0) ? 2 : 1
        [calc(outer), char, " " * inner, add(char), calc(outer),"\n"]
      end
    end

    def calc(count)
      " " * count
    end

    def add(char)
      char == "A" ? "" : char
    end
  end
end
