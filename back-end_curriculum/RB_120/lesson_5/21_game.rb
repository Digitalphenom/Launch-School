require "yaml"
require "pry"

PROMPT = YAML.load_file('21_prompts.yml')

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Participant
  attr_reader :choice

  def initialize()
    #@name = name
    @choice = nil
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
end

class Dealer < Participant
  def deal
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Deck
  attr_accessor :user_cards, :dealer_cards, :user_total, :dealer_total

  SUITS = [:Diamonds, :Hearts, :Spades, :Clubs]
  RANKS = [:Queen, :Jack, :King, :Ace]

  def initialize
    @deck = SUITS.map { |suit| [suit, [(2..10).to_a ,RANKS].flatten] }.to_h
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
    puts "Player Cards: #{user_cards} Your running total is: #{@user_total}"
    puts "Dealer Cards: #{dealer_cards} Dealer total: #{@dealer_total}" 
  end

  def get_card_states
    @user_card_state = Card.new(user_cards)
    @dealer_card_state = Card.new(dealer_cards)
  end

  def get_total
    @user_total = @user_card_state.get_total.sum
    @dealer_total = @dealer_card_state.get_total.sum
  end

  def add_to_deck
    user_cards << @deck[SUITS.sample].sample
  end

end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

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

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Game
  attr_reader :deck, :player

  def initialize
    @deck = Deck.new
    @player = Player.new
  end

  def show_initial_cards
    puts
    deck.display_cards
  end

  def clear_screen
    system "clear"
  end

  def hit_or_stay
    puts
    puts PROMPT["hit_or_stay"]
    puts PROMPT["options"]
    @choice = gets.chomp
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


  def player_turn
    loop do 
      hit_or_stay
      if hit_or_stay_choice == "1"
        deck.add_to_deck
        clear_screen
        show_initial_cards
      else
        dealer.turn
      end
      break
    end
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
      deck.deal
      show_initial_cards

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


