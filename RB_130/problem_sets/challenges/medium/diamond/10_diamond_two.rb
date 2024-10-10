
class Diamond
  def self.make_diamond(n)
    top_alph = ("A"..n).to_a
    top_size = top_alph.size * 2
    bottom_alph = ("A"...n).to_a
    bottom_size = bottom_alph.size * 2 + 1
    
    #t = generate_top(top_alph, top_size)
    b = generate_top(bottom_alph, bottom_size).reverse
    #(t + b).join
  end
  
  class << self
    private
    
    def generate_top(sequence, size)
      return ["A\n"] if sequence.size == 1
      @@count = 0

      sequence.map do |char|
        insert_chars(char).center(size) + "\n"
      end
    end

    def insert_chars(char)
      if char == "A"
        char
      else
        char + insert_white_space(char) + char
      end
    end

    def insert_white_space(char)
      if char == "B"
        @@count += 1
        " " * @@count
      else
        @@count += 2
        " " * @@count
      end
    end
  end
end

#Diamond.make_diamond("E")

# space = 0
#       Proc.new do |char|
#         if char == "B"
#           space += 1
#           " " * space
#         else
#           space += 2
#           " " * space
#         end
#       end