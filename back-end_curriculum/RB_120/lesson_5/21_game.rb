require "yaml"


PROMPT = YAML.load_file('21_prompts.yml')

class Player
  def initialize
    @user# what would the "data" or "states" of a Player object entail?
    @dealer# maybe cards? a name?
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

class Participant
  # what goes in here? all the redundant behaviors from Player and Dealer?
end

class Deck
  attr_accessor :user_cards, :dealer_cards

  SUITS = [:Diamonds, :Hearts, :Spades, :Clubs]
  VALUES = [:Queen, :Jack, :King, :Ace]

  def initialize
    @deck = SUITS.map { |suit| [suit, [(2..10).to_a ,VALUES].flatten] }.to_h
    @user_cards = []
    @dealer_cards = []
  end

  def deal
    # the action of dealing cards, entails extracting 2 sets of 2 cards from the deck to give to each player
    2.times { user_cards << @deck[SUITS.sample].sample }
    2.times { dealer_cards << @deck[SUITS.sample].sample }

  end

  def display_cards
    puts "Player Cards: #{user_cards} Dealer Cards: #{dealer_cards}"
    #"Player Cards:[jack, 10] Dealer Cards: [queen, ace]"
  end

end

class Card
  def initialize
    # what are the "states" of a card?
  end
end

class Game
  attr_reader :deck

  def initialize
    @deck = Deck.new
  end

  def show_initial_cards
    deck.display_cards
  end

  def display_welcome_message
    puts PROMPT["welcome"]
    puts PROMPT["name"]
    name = get_name
    puts "Ok #{name} heres the deal.."
  end
  
  def get_name
    gets.chomp
  end
  
  def start_game
    puts
    puts PROMPT["start_game"]
    gets.chomp
  end

  def start
    display_welcome_message
    loop do 
      n = start_game
      next unless n == "1"
      deck.deal
      show_initial_cards


      # player_turn
      # dealer_turn
      # show_result
      break
    end
  end
end

Game.new.start

#Dealer        Diana
#[?, 5]      [5, 10]

