=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

create a class that generates the lyrics of 99 bottles of beer

▣ Explicit Requirements

▣ Implicit Requriements
  □ define verse class method
    - accepts 1 or 2 arguments representing the lyric verse number
     0 is the last verse in song
     99 is the first verse

  □ define lyrics class method
    □ should generate entire song

  □ each verse is composed of 2 sentences that end with (\n) representing a new line

    1:"99 bottles of beer on the wall, 99 bottles of beer.\n" \
    2:"Take one down and pass it around, 98 bottles of beer on the wall.\n"

  □ final verse is also composed of two sentences
    1:"No more bottles of beer on the wall, no more bottles of beer.  \n" \
    2:"Go to the store and buy some more, 99 bottles of beer on the   wall.\n"

  □ when two arguments are passed it should return the verse from the first argument upto the second

  □ the second to last verse changes from (x) bottles (no more)
    "1 bottle of beer on the wall, 1 bottle of beer.\n" \
      "Take it down and pass it around, (no more) bottles of beer on the wall.\n"


#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄


#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
Input: verse number one or two
  intermediary: 
    get lyrics
    interpolate number or data
    return verse/s
output: string verse

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

▣ Create BeerSong class

▣ define (verse) class method
  □ should accept 1 argument
    - generate (argument number) verse
     ﹥interpolate argument number in first sentence
     ﹥ interpolate argument number minus one in second sentence
      "(99) bottles of beer on the wall, (99) bottles of beer.\n" \
       "Take one down and pass it around, (98) bottles of beer on the wall.\n"
      ﹥ if argument number is 1
        replace second sentence interpolated value from (arg num - 1) to (no more)
        "1 bottle of beer on the wall, 1 bottle of beer.\n" \
        "Take it down and pass it around, (no more) bottles of beer on the wall.\n"
      ﹥ if arg count is 0
        "No more bottles of beer on the wall, no more bottles of beer.\n" \
        "Go to the store and buy some more, 99 bottles of beer on the wall.\n"

▣ define (verses) class method
  □ should accept two arguments
   - sequence begins from large to small
    access current number and return corresponding verse upto second arg

▣ define lyrics class method
  □ generate all lyrics from 0 upto 99
    - generate sequence from 0 upto 99
      return corresponding verse for each
   
=end

class BeerSong
  def self.verse(verse)
    BeerSong.new.find_verse(verse)
  end

  def self.verses(ending, start)
    song = BeerSong.new
    lyrics = []

    (start..ending).reverse_each do |number|
      lyrics << song.find_verse(number)
    end
    lyrics.join("\n")
  end

  def self.lyrics
    verses(99, 0)
  end

  def find_verse(verse)
    case verse
    when (3..99)
      "#{verse} bottles of beer on the wall, #{verse} bottles of beer.\n" \
      "Take one down and pass it around, #{verse - 1} bottles of beer on the wall.\n"
    when 1
      "#{verse} bottle of beer on the wall, #{verse} bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    when 2
      "#{verse} bottles of beer on the wall, #{verse} bottles of beer.\n" \
      "Take one down and pass it around, #{verse - 1} bottle of beer on the wall.\n"
    when 0
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    end
  end
end
