require "yaml"
require "pry"

PROMPT = YAML.load_file('21_prompts.yml')
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Participant
  attr_reader :choice, :cards

  def initialize()
    #@name = name
    @cards = []
    @total = 0
    #@choice = nil
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Player < Participant
  def turn?
    @turn = true
    false if stay
  end
end

class Dealer < Participant
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Deck
  attr_reader :deck

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = []
    generate_deck
  end

  def generate_deck
    52.times {|_| deck << Card.new(RANKS.sample, SUITS.sample) } 
  end

  # If we are to more the real world version of cards, we would give the ability to `deal` to the dealer. However in our program this would require the dealer to collaborate with the deck in order to `know` the deck, which creates an additional `dependency`. For this reason it might be best to leave the dealing of cards to the `Deck`.
  def deal
    generate_deck if deck.empty?
    deck.pop
  end

end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Card
  attr_reader :rank, :suit

  RANK = {
    'Jack' => 10,
    'Queen' => 10,
    'King' => 10,
    'Ace' => 11
  }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    v1 = RANK.fetch(rank, rank)
    v2 = RANK.fetch(other.rank, other.rank)
    v1 <=> v2
  end

#  def to_s
#    "#{rank} of #{suit}"
#  end

end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
# The game class is responsible for aspects of the game that relate to playing and display game actions.
class Game
  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def clear_screen
    system "clear"
  end

  def get_name
    gets.chomp
  end

  def display_welcome_message
    puts PROMPT["welcome"]
    puts PROMPT["name"]
    name = get_name
    puts "Ok #{name} heres the deal.."
  end

  def hit_or_stay
    puts
    puts PROMPT["hit_or_stay"]
    puts PROMPT["options"]
    @choice = gets.chomp
  end

  def display_all_cards
    puts "Player Cards:"
    puts "#{display_cards(player)}"
    puts "Your running total is: #{}"
    puts "------------------------"
    puts "Dealer Cards:"
    puts "#{display_cards(dealer)}"
    puts "Dealer total: #{}" 
  end

  def display_cards(participant)
    participant.cards.each { |card| puts "- #{card.rank} of #{card.suit}"}
    nil
  end

  def start_game
    puts
    puts PROMPT["start_game"]
    gets.chomp
  end

  def player_turn
    loop do 
      hit_or_stay
      if hit_or_stay_choice == "1"
        deck.deal
        clear_screen
        show_initial_cards
      else
        dealer.turn
      end
      break
    end
  end

  def deal_card
    player.cards << deck.deal if player.turn?
    dealer.cards << deck.deal
  end

  def init_cards
    2.times { player.cards << deck.deal }
    2.times { dealer.cards << deck.deal }
  end
    # here we prompt the user if he wants to hit or stay and fill in the required logic for each choice.
    # if stay then we pass the turn to dealer
    # if HIT then we add 1 card to the pile and reflect that to the screen by updating stats.

  def start
    display_welcome_message
    loop do 
      n = start_game
      next  unless n == "1"
      clear_screen
      init_cards
      display_all_cards

      player_turn()
      # after dealers turn, check cards and show results
      # show_result
      break
    end
  end
end

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞
Game.new.start

#Dealer        Diana
#[?, 5]      [5, 10]


