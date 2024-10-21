=begin

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# Given two input strings, get the shortest length and make them both equal in length. compare second string with first string and keep a count of the differences in char. return count

Write a program that calcualtes the hemming distance between two dna strands

 A point mutation is when a (base) is replaced with another at a single (nucleotide)

  GAGCCTACTAACGGGAT
  CATCGTAATGACGGCCT
  ^ ^ ^  ^ ^    ^^
  ▣ Explicit requirements
    □ if two sequences of unequal length
      compute shorter length

  ▣ Implicit requirements
    □ new receives the initial dna
    □ hamming_distance receives the altered dna

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
empty returns 0

DNA.new('GGACTGA').hamming_distance('GGACTGA') => 0

ACT <=> GGA +=> 3 all are different

filter from smallest of both inputs
GGACGGATTCTGACCTGGACTAATTTTGGGG
AGGACGGATTCTG-ACCTGGACTAATTTTGG(G)
19

GACTACGGACAGG-GTAGGGAAT
GACATCGCACACC

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

Input: string dna

intermediary : find smallest length
              remove remaining chars if one is larger
              access each char
              count non-matches

output: count of unmatching chars

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  ▣ Create DNA class
  ▣ create constructor method
    □ capture input dna in @dna iv
  ▣ create hamming_distance im
    □ should accept a dna input string
    □ compare dna's to find shortest length
      ﹥ if same size move one
      ﹥ if initial input is greater than other input
        □ get largest
          ﹥ access last element & remove
          ﹥ check if larger
            - if larger continue
              ﹥ if equal return
    □ find differences
      ﹥ create differences helper method
      ﹥ access initail dna char and compare with other_dna
        ﹥ if different ad one to count
        ﹥ else move on
        ﹥ return count

=end

class DNA
  attr_reader :dna

  def initialize(dna)
    @dna = dna
  end

  def hamming_distance(other_dna)
    if dna.size == other_dna.size
      find_missing(dna, other_dna)
    elsif dna.size < other_dna.size
      find_missing(dna, remove_extra(other_dna, dna))
    else
      find_missing(other_dna, remove_extra(dna, other_dna))
    end
  end

  def remove_extra(dna, other_dna)
    until dna.size == other_dna.size
      dna = dna[0..-2]
    end
    dna
  end

  def find_missing(dna, dna2)
    diff = 0
    (0...dna.size).each do |i|
      next if dna[i] == dna2[i]
      diff += 1
    end
    diff
  end
end

# ls solution

class DNA

  def initialize(dna)
    @dna = dna
  end

  def hamming_distance(other_dna)
    shorter = @dna.size < other_dna.size ? @dna : other_dna
    difference = 0

    shorter.size.times do |i|
      next if @dna[i] == other_dna[i]
      difference += 1
    end

    difference
  end
end