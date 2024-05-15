=begin
⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
Modify the class so that each instance returns a corresponding card and displays the card attribute when you call `puts` on the instance:
  "Jack of Diamonds", "4 of Clubs", etc.

  ▣ Return attribute of card when calling puts on instance
  ▣ Each instance should return the card passed as an argument ie `2, 'Hearts'`
  ▣ A min method should return the minimum ranked card
  ▣ A max method should return the maximum ranked card
  ▣ A rank reader method should return the cards rank
  ▣ rank refers to the value of the card
  ▣ A suit has no relative value to its rank
    □ A suit of Diamonds with a rank of 8 is not greater than (Hearts, 8)
  ▣ Cards from 2-10 are lower than Jacks
  ▣ Jacks are lower than Queens
  ▣ Queens are lower than Kings
  ▣ Kings are lower than Aces

  # Since we need to get the relative minimum and maximum cards not only of integer values but Strings we must create a rank profile and teach ruby through custom defined `min` and `max` methods how to rank each card when it is encountered.

Further exploration tasks us with adding a rank to each suit so that a 4 of spade outranks a 4 of hearts and so on..:
  spades => hearts => clubs => diamonds

This can be implemented by incrementing the return value of the rank card with a given suit value. Where a greater suit adds 4 to a given rank and diamonds adds 1.
  

=end

require 'pry'

class Card
  include Comparable
  attr_reader :rank, :suit

  RANK = {
    'Jack' => 11,
    'Queen' => 12,
    'King' => 13,
    'Ace' => 14
  }

  SUIT = {
    'Diamonds' => 1,
    'Clubs' => 2,
    'Hearts' => 3,
    'Spades' => 4
  }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{@rank} of #{suit}"
  end

  #def ==(other)
  #  rank == other.rank && suit == other.suit
  #end

  def <=>(other)
    v1 = RANK.fetch(rank, rank) + SUIT.fetch(suit)
    v2 = RANK.fetch(other.rank, other.rank) + SUIT.fetch(other.suit)
    #binding.pry
    v1 <=> v2
  end

end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
cards = [Card.new('Ace', 'Hearts'),
  Card.new('Ace', 'Diamonds'),
  Card.new('Ace', 'Clubs')]
puts cards
# This output is a little confusing but what I believe is happening is that `cards.min` returns the rank and is being compared implicitly with the rank of the other object. The equality method as defined on the return value of `cards.min` is being called and implicitly converts the object so that its compared with the other rank. The default output of 'Rank of Suit' is a byproduct of the to_s method which obscures the underlying mechanics outlined. This is why we can remove the ==() defined on the class unless we want to further specify how cards are compared. Since the instructions stated that the `suits` dont matter, there is no need for further specifying the equality operator.
p cards.max
p cards.max == Card.new('Ace', 'Hearts')
p cards.min == Card.new(2, 'Hearts')


