=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  Given an input word string, tally its total scrabble points and return them.

  ▣ Explicit Requirments
    □ return total points
  
  ▣ Implicity requirements
    □ Empty string return 0
    □ nil returns 0
    □ regex inputs return 0
    □ Case insensitive
      □ O & o are treated the same
    □ Point System to compare each input word

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

3 + 2 + 6 + 2 + 1

quirky
(10 + 1)  +(1 + 1) +( 5  + 4 ) 22

OXYPHENBUTAZONE
(1 + 8 )+ 4 +  3 + 4 + 1 + 1 + 3 + 1 + 1 +1 + 10 + 1 +1 + 1
9 +7  +5 + 4  +2 + 11 + 2 +  1
16 + 9  + 13 + 3
25 +  16
41 

3 + 2 + 6 + 2 + 1
5 +  8 +  1
13 + 1
14

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

Upon instantiatig a Scrabble instance
Input: String word

  Use an accumulator to track points
    ﹥ counter
    ﹥ array 

Score instance method should return 
Output: Integer

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟Algorithm◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  ▣ Defining Scrabble class along with a constructor method that capsutes the input word in a iv named input_word. Expose word with reader

  ▣ Create a Point system data strucutre
    □ hsh point system => {1, []}

  ▣ Define an instance method named `score` that returns the total points accumulated.
    □ Ensure input_word is indeed a word
      ﹥ if not return 0
    □ Upcase input word
    □ Convert input words into chars
    □ access each char and retrieve its corresponding point
      ﹥ comparing char with point system   
        ﹥ iterate through point system
          ﹥ iterate through each input char
            check if hsh value includes the input char
              [a, d].includes?(A) add key
              if true add key
              false go next
  ▣ Return total points

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

=end

class Scrabble
  attr_reader :input_word

  def initialize(input_word)
    @input_word = input_word ? input_word : ''
  end

  def self.point_system
    { 1 => %w(A E I O U L N R S T),
      2 => %w(D G),
      3 => %w(B C M P),
      4 => %w(F H V W Y),
      5 => %w(K),
      8 => %w(J X),
      10 => %w(Q Z)
      "hello"
    }
  end

  def self.score(word)
    Scrabble.new(word).score
  end

  def score
    return 0 if input_word.strip.empty?
    
    input_word.upcase.chars.map do |char|
      Scrabble.point_system.each do |point, sub_arr|
        break point if sub_arr.include?(char)
        0
      end
    end.sum
  end
end
