

=begin

 Create a deck class that contains all the standard 52 playing cards. Simulate the drawing of a card with a `#draw` method. Every time an object is instantiated the deck should be re-shuffled. The deck should reset itself by generting a new 52 set of shuffled cards when there are no more cards in the deck.

 ▣ Everytime an object is instantiated a new deck of 52 cards should be generated in random order (shuffled)
  □ Access a Rank & Suit
    □ The access of each rank & suit should be random to simulate the shuffling nature of a deck.
  □ Place into a deck
    □ 
  □ repeat 52 times

 ▣ A draw method should extract one card from the deck.

 define a draw method. When the method is invoked it should extract one card from the deck and add it to the calling object (array).
 Each card should be represented by an object not sub-arrays.
=end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Deck
  include Comparable

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_reader :deck
  
  def initialize
    @deck = []
    generate_deck
  end
  
  def draw
    generate_deck if deck.empty?
    deck.pop
  end

  private

  def generate_deck
    52.times {|_| deck << Card.new(RANKS.sample, SUITS.sample) } 
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Card
  include Comparable
  
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

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

  def to_s
    "#{@rank} of #{suit}"
  end

  def <=>(other)
    v1 = RANK.fetch(rank, rank) + SUIT.fetch(suit)
    v2 = RANK.fetch(other.rank, other.rank) + SUIT.fetch(other.suit)
    v1 <=> v2
  end
end


#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card|  card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.