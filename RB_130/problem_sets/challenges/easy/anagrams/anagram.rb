

=begin

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
  Write a method that takes a list of words and returns a new array composed of anagrams.

    ▣ Explicit requirements
      □ Return new array
      □ array should contain anagrams only

    ▣ Implicity requirements
      □ the word to compare the list with will be passed when instantiating a Anagram class.
      □ The method name should be defined as #detector
      □ The `match` method will be called on `dectector` so detector must return a string word.
      □ List of words will contains both upper & lower chars

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

 Anagram.new('listen')
 In this example `listen` is the anagram and:
 %w(enlists google inlets banana) is our list of words
 of which `inlets` is an anagram and the return value is ['inlets']

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
  Class Input: word = String
  #Detector Output sorted string

  #Match Method Input array of string words
   What will match do with those words and the sorted string #detector returns?
  
  #Match Output: Array of original words that are anagrams

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algo ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
  ▣ Create Anagram class along with constructor method
    □ Constructor method should initialize a word iv and expose it via reader emthod

  ▣ Define a `detector` instance method
    □ Sort input string & return

  ▣ Define #Match method that takes a list as an argument.
    □ Access each word and compare it with the return value of `detector`.
      □ Comparison should be of sorted words
        "listen" => "eilnst" == "inlets" => "eilnst"
        if match place in new array otherwise skip.
    
  ▣ Return array 
=end

class Anagram
  attr_reader :input_word

  def initialize(word)
    @input_word = word.downcase
  end

  def match(arr)
    arr.select do |list_word|
      next if input_word == list_word.downcase
      sort_word(input_word) == sort_word(list_word.downcase)
    end
  end

  private

  def sort_word(word)
    word.chars.sort.join
  end
end

=begin
# ok there are 3 glaring assumptions I made and led this to implementing a partial solution

# The first is I assumed that `dector` was a method when infact its what they named an instance of Anagram.
# Well actually that's the main mistake that led to other mistakes such as that detector should return a string and compare each string with a match method that would be chained on to detector but since match is also an instance method of `string` we must ensure detector returns an instance. This then led to not understanding why `self` wasnt referring to the object that the calling object returns and is amking me doubt whether my understanding is correct.

So to clariy, detectr is an instance of Anagram and `#match` is the sole method we should define.
=end