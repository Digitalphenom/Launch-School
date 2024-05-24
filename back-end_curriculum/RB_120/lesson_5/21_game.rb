require "yaml"
require "pry"

PROMPT = YAML.load_file('21_prompts.yml')
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Participant
  attr_reader :choice
  attr_writer :cards, :total

  def initialize
    @name = 'Dealer'
    @cards = []
    @total = 0
  end

  def total
    @total = hit.map { |card| Card::RANK.fetch(card.rank,card.rank)}.sum
  end

  def hit
    @cards
  end

  def busted?
    @total > 21
  end

  def to_s
    @name
  end

  def reset_stats
    self.total = 0
    self.cards = []
  end

end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Player < Participant
  attr_reader :name

  def initialize(name)
    @name = name
    super()
  end

  def set_name(name)
    self.name = name
  end

  private
  attr_writer :name
end

class Dealer < Participant

  def hidden_cards
    puts @cards.last
  end

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
  def draw
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

  def to_s
    "#{rank} of #{suit}"
  end

end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Game
  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new("?")
    @dealer = Dealer.new
  end

  def clear_screen
    system "clear"
  end

  def get_name
    player.set_name(gets.chomp)
  end

  def display_welcome_message
    puts PROMPT["welcome"]
    puts PROMPT["name"]
    get_name
    puts PROMPT["instructions"]
  end

  def hit_or_stay_choice
    puts
    puts PROMPT["hit_or_stay"]
    puts PROMPT["options"]
    gets.chomp
  end

  def cards_screen
    puts "Dealer Cards:"
    "#{dealer.hidden_cards}"
    puts "--------------------"
    puts "#{player.name} Cards:"
    puts "#{display_all_cards(player)}"
    puts "Your running total is: #{player.total}"
    puts
  end

  def dealer_cards
    puts "Dealer Cards:"
    "#{display_all_cards(dealer)}"
    puts "Total: #{dealer.total}"
  end

  def display_all_cards(participant)
    participant.hit.each { |card| puts "- #{card.rank} of #{card.suit}"}
    nil
  end

  def participant?(participant)
    participant.class == Player
  end

  def start_choice
    puts
    puts PROMPT["start_game"]
    gets.chomp
  end

  def init_cards
    2.times { player.hit << deck.draw }
    2.times { dealer.hit << deck.draw }
  end

  def evaluate_cards
    if dealer.busted?
      display_busted(dealer)
      winner(player) 
    elsif player.total > dealer.total
      winner(player) 
    elsif player.total == dealer.total
      tie_game
    else
      winner(dealer)
    end
  end

  def player_turn
    loop do 
      choice = hit_or_stay_choice
      player.hit << deck.draw if choice == '1'
      clear_screen
      cards_screen
      break if player.busted? || choice == '2'
    end
  end

  def dealer_turn
    puts "Dealers Turn.."
    until dealer.total >= 17
      dealer.hit << deck.draw
      puts
      puts "The Dealer Hits!" 
      puts "Dealer Cards"
      print "#{dealer.hidden_cards}"
    end
  end

  def tie_game
    puts "Its a tie"
  end

  def winner(participant)
    puts "#{participant} Wins The Game" 
  end
  
  def display_busted(participant)
    puts "BUSTED! #{participant} loses.."
    puts
  end

  def play_again?
    puts
    puts PROMPT["play_again?"]
    puts PROMPT["play_again_choice"]
    gets.chomp
  end

  def exit_screen
    puts PROMPT["exit_screen"]
  end

  def reset_stats
    player.reset_stats
    dealer.reset_stats
  end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  def play_game
    player_turn
    return display_busted(player) if player.busted?
    puts 
    dealer_turn

    evaluate_cards
    puts
  end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  def ready_to_play
    loop do 
      choice = start_choice
      next unless choice == "1"
      clear_screen
      init_cards
      cards_screen
      break
    end
  end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  def start
    display_welcome_message
    loop do 
      ready_to_play
      return display_busted(player) if player.busted?
      play_game
      dealer_cards
      break unless play_again? == "1"
      reset_stats
      clear_screen
    end
    exit_screen
  end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
end

Game.new.start



