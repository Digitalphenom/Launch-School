require "yaml"
require "pry"

PROMPT = YAML.load_file('21_prompts.yml')

class Player
  def initialize
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

class Participant
  # what goes in here? all the redundant behaviors from Player and Dealer?
end

class Deck
  attr_accessor :user_cards, :dealer_cards, :user_total, :dealer_total

  SUITS = [:Diamonds, :Hearts, :Spades, :Clubs]
  VALUES = [:Queen, :Jack, :King, :Ace]

  def initialize
    @deck = SUITS.map { |suit| [suit, [(2..10).to_a ,VALUES].flatten] }.to_h
    @user_cards = []
    @dealer_cards = []
    @user_card_state = nil
    @dealer_card_state = nil
  end

  def deal
    # the action of dealing cards, entails extracting 2 sets of 2 cards from the deck to give to each player
    2.times { user_cards << @deck[SUITS.sample].sample }
    2.times { dealer_cards << @deck[SUITS.sample].sample }

  end

  def display_cards
    get_card_states
    get_total
    puts "Player Cards: #{user_cards} Total: #{@user_total} Dealer Cards: #{dealer_cards} Total: #{@dealer_total}" 
  end

  def get_card_states
    @user_card_state = Card.new(user_cards)
    @dealer_card_state = Card.new(dealer_cards)
  end

  def get_total
    @user_total = @user_card_state.get_total.sum
    @dealer_total = @dealer_card_state.get_total.sum
  end
  

end

class Card
  attr_reader :player_cards

  def initialize(player_cards)
    @player_cards = player_cards
    # what are the "states" of a card?
  end

  def get_total
    player_cards.map do |card|
      case card
      when :Queen then 10
      when :Jack then 10
      when :King then 10
      when :Ace then 11
      else
        card
      end
    end
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

