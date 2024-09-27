=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  Create a class named `BeerSong` along with an instance method named `verses` that takes either a single integer argument or 2 integer arguments that represent the count in the verse song `99bottles`. A lyrics instance methods should generate all possible verses begining from 99 downto 0

    ▣ Requirements
      □ The default verse reads:
       ﹥ "(arg) bottles of beer on the wall, (arg) bottles of beer.\n" \
      "Take one down and pass it around,(arg- 1 (98) bottles of beer on the wall.\n"

      □ Special verses are the final = verse 1 & verse 0 which read respectively:
          ﹥ "1 bottle of beer on the wall, 1 bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n" \"
      
          ﹥ "no more bottles of beer on the wall, no more bottles of beer.\n \ Go to the store and buy some more, 99 bottles of beer on the wall.\n""

      □ If verse method is passed 2 arguments, it should generate a verse from the first arg down to the second
      □ If verse passed a single argument it should generate the verse at the specified arguments position.

      ▣ Observations  
        □ the word `bottles` should change to `bottle` when the verse count is at 1.
        □ verses from 99 down to 2 should subtract its verses number in the second sentence
        □ If verse is 1 the second sentence verse number should be subsibuted with `no more`
        □ Ensure to include new line char between sentences (\n)

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄



#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄


Input: integer | 1 or 2
 Generate a sequence of verses from 99 down to 0
 output each sequence based on the specified arguments
Output: String verse

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟Algo◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  ▣ Generate a sequence of indexs beginning from the first arg down to the second verse.
    □ if no second verse is provide defult to first verse num
    □ Interpolate current index into verse count.
    □ second sentence should subtract by 1
  ▣

=end

class BeerSong

  def self.verses(from, to = from)
    verse = Verse.new
    beer_song = ''

    from.downto(to) do |bottle_count|
      beer_song += verse.generate(bottle_count) + "\n\n"
    end
    beer_song.chomp
  end

  def self.verse(from)
    verses(from)
  end
  
  def self.lyrics
    verses(99, 0)

  end
end

class Verse
  def generate(bottle_count)
    word = bottle_count == 2 ? 'bottle' : 'bottles'

    case bottle_count
    when (2..99)
      "#{bottle_count} bottles of beer on the wall, #{bottle_count} bottles of beer.\n" \
    "Take one down and pass it around, #{bottle_count - 1} #{word} of beer on the wall."
    when 1 
      "1 bottle of beer on the wall, 1 bottle of beer.\n" \
    "Take it down and pass it around, no more bottles of beer on the wall."
    else
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
    "Go to the store and buy some more, 99 bottles of beer on the wall."
    end
  end

end

p BeerSong.verses(3)


