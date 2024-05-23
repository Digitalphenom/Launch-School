require "yaml"
require "pry"

PROMPT = YAML.load_file('21_prompts.yml')
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Participant
  attr_reader :choice

  def initialize()
    #@name = name
    @cards = []
    @total = 0
    #@choice = nil
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
  end

  def total
    @total = hit.map { |card| Card::RANK.fetch(card.rank,card.rank)}.sum
  end

  def hit
    @cards
  end

  def stay
    false
  end

  def busted?
    @total > 21
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

  def to_s
    "#{rank} of #{suit}"
  end

end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
# The game class is responsible for aspects of the game that relate to playing and display game actions.
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

  def display_cards
    puts "Dealer Cards:"
    "#{dealer.hidden_cards}"
    puts "--------------------"
    puts "#{player.name} Cards:"
    puts "#{display_all_cards(player)}"
    puts "Your running total is: #{player.total}"
  end

  def display_all_dealer_cards
    puts "Dealer Cards:"
    "#{display_all_cards(dealer)}"
    puts "Dealer Total:"
    puts "#{dealer.total}"
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

  def turn(participant)
    deal_card(participant)
    clear_screen
    display_cards
  end

  def deal_card(participant)
    return player.hit << deck.deal if participant?(participant)
    dealer_turn
  end

  def dealer_turn
    until dealer.total >= 17
      dealer.hit << deck.deal
    end
  end

  def init_cards
    2.times { player.hit << deck.deal }
    2.times { dealer.hit << deck.deal }
  end

  def evaluate_cards
    if dealer.busted? || player.total > dealer.total
      display_all_dealer_cards
      return winner(player) 
    else
      winner(dealer)
    end
  end

  def winner(participant)
    if participant.class == Player
      puts "You Win The Game" 
    else
      puts "You Lose The Game"
    end
  end
  
  def display_busted
    puts "BUSTED! You lose.." #if player.to
  end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  def play_game
    loop do 
      choice = hit_or_stay_choice
      turn(player) if choice == '1'
      break if player.busted? || choice == '2'
    end
    return display_busted if player.busted?
    puts "Dealers Turn.."
    loop do
      #binding.pry
      turn(dealer)
      break 
    end
    evaluate_cards
    puts
    display_all_dealer_cards
    # after dealers turn, check cards and show results
    # show_result
  end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  def ready_to_play
    loop do 
      choice = start_choice
      next unless choice == "1"
      clear_screen
      init_cards
      display_cards
      break
    end
  end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  def start
    display_welcome_message
    ready_to_play

    play_game
  end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
end

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞
Game.new.start

#Dealer        Diana
#[?, 5]      [5, 10]


