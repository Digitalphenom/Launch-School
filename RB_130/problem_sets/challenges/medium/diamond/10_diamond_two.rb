class Diamond
  def self.make_diamond(n)
    top_alph = ("A"..n).to_a
    top_size = top_alph.size * 2
    bottom_alph = ("A"...n).to_a
    bottom_size = bottom_alph.size * 2 + 1
    @@bottom = nil
    
    diamond = generate_top(top_alph, top_size) +generate_top(bottom_alph, bottom_size).reverse
    diamond.join("\n") + "\n"
  end
  
  class << self
    private
    
    def generate_top(sequence, size)
      @@count = 0
      result = []

      result = sequence.map do |letter|
        insert_chars(letter).center(size)
      end
      result
    end

    def insert_chars(letter)
      return "A" if letter == "A" && @@bottom.nil?
      letter + insert_white_space(letter) + letter
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

p Diamond.make_diamond("B")
