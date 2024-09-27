class DNA
  def initialize(dna)
    @dna1 = dna
  end

  def hamming_distance(input_dna)
    shortest, longest = shortest_dna(input_dna)

    shortest.chars.each_with_index.reduce(0) do |acc, (char, i)|
      break if char.nil? || longest[i].nil?
      next acc += 1 if char != longest[i]
      acc
    end
  end()
  
  def shortest_dna(dna2)
    @dna1.size <= dna2.size ? [@dna1, dna2] : [dna2, @dna1]
  end
end

=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
Given a DNA as an input, return the hamming point distance which translates to return the total character differences in the input string from an original string ensuring to remove excess characters from the greatest in length DNA.

  ▣ Input DNA to be tested on will either be equal or greater/less than in length
  ▣ When a dna or input is greater or shorter the greatest of either original or input dna should be ignored
  ▣

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

(GGACTGA) (GGACTGA) == 0
There is not character difference in this string so we return 0
There is not character difference in this string so we return 0

ACT  GGA
All character are different so we return 3

AAACTAGGGG
AGGCTAGCGG*TAGGAC

GACTACGGACAGG*GTAGGGAAT
GACATCGCACACC

AGACAA*CAGCCAGCCGCCGGATT
AGGCAA

AGACAACAGCCAGCCGCCGGATT
AGACATCTTTCAGCCGCCGGATT*AGGCAA

AGA*CAACAGCCAGCCGCCGGATT
AGG

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

Input: String
# The middle step can be handled by dealing with the string directly using regex to manipulate it
Ouput: Integer representing hemming distance

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ ALgo ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
  ▣ Compare original and input DNA 
    □ if Equal in length proceed to next step
    □ If not equal
      □ remove remaning characters from string who is greatest in length
        □ Determine what string is least in length
      
        □ Begin from the total size of smallest string upto the size of the greatest in length
  
  ▣ Access each character from both strings simultenously
    □ compare character
      □ if even go next
      □ if not even add to count
      □ process all pairs

  ▣ Return count

  option 2
  ▣ 

=end
