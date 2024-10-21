class Diamond
  def self.make_diamond(letter)
    range = ('A'..letter).to_a + ('A'...letter).to_a.reverse
    diamond_width = max_width(letter)

    range.each_with_object([]) do |let, arr|
      arr << make_row(let).center(diamond_width) + "\n"
    end.join#("\n") #+ "\n"

  end

  class << self
    private

    def make_row(letter)
      return "A" if letter == "A"
      return "B B" if letter == "B"

      letter + determine_spaces(letter) + letter
    end

    def determine_spaces(letter)
      all_letters = ['B']
      spaces = 1

      until all_letters.include?(letter)
        current_letter = all_letters.last
        all_letters << current_letter.next
        spaces += 2
      end

      ' ' * spaces
    end

    def max_width(letter)
      return 1 if letter == 'A'

      determine_spaces(letter).count(' ') + 2
    end
  end
end

answer = Diamond.make_diamond('C')
p answer == string = "  A  \n"\
" B B \n"\
"C   C\n"\
" B B \n"\
"  A  \n"