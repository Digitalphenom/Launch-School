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

=end

class Card #< Array
  include Comparable
  attr_reader :rank, :suit



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
    v1 = convert_card(rank)
    v2 = convert_card(other.rank)
    v1 <=> v2
  end

  def convert_card(rank)
    return 11 if rank == 'Jack'
    return 12 if rank == 'Queen'
    return 13 if rank == 'King'
    return 14 if rank == 'Ace'
    rank
  end

end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
cards = [Card.new(2, 'Hearts'),
  Card.new(10, 'Diamonds'),
  Card.new('Ace', 'Clubs')]
puts cards
# This output is a little confusing but what I believe is happening is that `cards.min` returns the rank and is being compared implicitly with the rank of the other object. The equality method as defined on the return value of `cards.min` is being called and implicitly converts the object so that its compared with the other rank. The default output of 'Rank of Suit' is a byproduct of the to_s method which obscures the underlying mechanics outlined. This is why we can remove the ==() defined on the class unless we want to further specify how cards are compared. Since the instructions stated that the `suits` dont matter, there is no need for further specifying the equality operator.
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Hearts')