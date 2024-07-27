require 'pry'

class Deck
  include Comparable

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_reader :deck, :draw
  
  def initialize
    @deck = []
    generate_deck
  end

  def self.rank
    RANKS
  end

  def self.suit
    SUITS
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

class PokerHand
  def initialize(cards)
    @cards = []
    @rank_count = Hash.new(0)

    5.times do
      card = cards.draw
      @cards << card
      @rank_count[card.rank] += 1
    end
  end

  def print
    puts @cards
  end

  def evaluate
    if    royal_flush?     then 'Royal flush'
    elsif straight_flush?  then 'Straight flush'
    elsif four_of_a_kind?  then 'Four of a kind'
    elsif full_house?      then 'Full house'
    elsif flush?           then 'Flush'
    elsif straight?        then 'Straight'
    elsif three_of_a_kind? then 'Three of a kind'
    elsif two_pair?        then 'Two pair'
    elsif pair?            then 'Pair'
    else 'High card'
    end
  end

  private

  def flush?
    suit = @cards.first.suit
    @cards.all? { |card| card.suit == suit }
  end

  def straight?
    return false if @rank_count.any? { |_, count| count > 1 }
    @cards.min.values == @cards.max.values - 4
  end

  def n_of_a_kind?(number)
    @rank_count.one? { |_, count| count == number }
  end

  def straight_flush?
    flush? && straight?
  end

  def royal_flush?
    straight_flush? && @cards.min.rank == 10
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    n_of_a_kind?(3) && n_of_a_kind?(2)
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    arr = @rank_count.select { |_, count| count == 2 }
    arr.size == 2
  end

  def pair?
    n_of_a_kind?(2)
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
