
=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
Write a program that takes a word and a list of possible anagrams and selects the correct sublist that contains the anagrams of the word.

 ▣ Explicit Requirements
  □ constructor method that takes a word arg
  □ match method that takes a list or postential anagrams
  □ return an array of anagrams
  □ array should be sorted from small to large

 ▣ Implicit
  □ duplicates are not anagrams
  □ case insensitive CORN CoRn does not match 'corn'
  □ all chars must match in type & must be of equal length


  - any word or phase that exactly reproduces the letters in another order is an anagram.

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

galea
eagle

listen
inlets

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

 Input: string word
    intermediary:
    convert word into array of chars
    sort
    compare each
    select equal words
    return selected 
 Output: array of anagrams

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ AL ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
=end

class Anagram
  attr_reader :word

  def initialize(word)
    @word = word.downcase
  end

  def match(array)
    sorted_word = word.chars.sort.join

    array.select do |anagram|
      anagram = anagram.downcase
      next if word == anagram

      sorted_anagram = anagram.chars.sort.join
      sorted_anagram == sorted_word
    end
  end
end