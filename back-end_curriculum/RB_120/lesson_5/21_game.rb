require "yaml"

PROMPT = YAML.load_file('21_prompts.yml')

module Formatable
  def new_line
    puts
  end
end

module CardSwapable
  def eleven_or_one!
    total_arr = @card_total[0...@card_total.size - 1]

    @card_total[-1] = 1 if @card_total.last == 11 && total_arr.sum >= 11
    @card_total
  end
end

class Participant
  attr_reader :choice
  attr_writer :cards, :card_total

  include CardSwapable

  def initialize
    @name = 'Dealer'
    @cards = []
    @card_total = []
  end

  def convert_next_card
    card = @cards.last
    @card_total << Card::RANK.fetch(card.rank, card.rank)
  end

  def card_total
    @card_total.sum
  end

  def hit
    @cards
  end

  def busted?
    card_total > 21
  end

  def to_s
    @name
  end

  def reset_stats
    self.card_total = []
    self.cards = []
  end
end

class Player < Participant
  attr_reader :name

  def initialize(name)
    @name = name
    super()
  end

  def add_name(name)
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

class Deck
  attr_reader :deck

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = []
    generate_deck
  end

  def generate_deck
    52.times { |_| deck << Card.new(RANKS.sample, SUITS.sample) }
  end

  def draw
    generate_deck if deck.empty?
    deck.pop
  end
end

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

class Game
  attr_reader :deck, :player, :dealer

  include Formatable

  def initialize
    @deck = Deck.new
    @player = Player.new("?")
    @dealer = Dealer.new
  end

  def clear_screen
    system "clear"
  end

  def prompt_name
    player.add_name(gets.chomp)
  end

  def welcome_message
    puts PROMPT["welcome"]
    puts PROMPT["name"]
    prompt_name
    puts PROMPT["instructions"]
  end

  def hit_or_stay_choice
    new_line
    puts PROMPT["hit_or_stay"]
    puts PROMPT["options"]
    gets.chomp
  end

  def cards_screen
    puts "Dealer Cards:"
    puts "#{dealer.hidden_cards}"
    puts "--------------------"
    puts "#{player.name} Cards:"
    puts "#{display_all_cards(player)}"
    puts "\nYour running total is: #{player.card_total}"
    new_line
  end

  def dealer_cards
    puts "Dealer Cards:"
    puts "#{display_all_cards(dealer)}"
    puts "Total: #{dealer.card_total}"
  end

  def display_all_cards(participant)
    participant.hit.each { |card| puts "- #{card.rank} of #{card.suit}" }
    nil
  end

  def participant?(participant)
    participant.instance_of?(Player)
  end

  def start_choice
    new_line
    puts PROMPT["start_game"]
    gets.chomp
  end

  def participant_hit(participant)
    participant.hit << deck.draw
  end

  def init_cards
    2.times { hit_and_add_total(player) }
    2.times { hit_and_add_total(dealer) }
  end

  def convert_card(participant)
    participant.convert_next_card
  end

  def hit_and_add_total(participant)
    participant_hit(participant)
    convert_card(participant)
  end

  def evaluate_cards
    player = player.card_total
    dealer = dealer.card_total
    return winner(player) if dealer.busted? || player > dealer
    return tie_game if player == dealer
    winner(dealer)
  end

  def check_for_eleven(participant)
    participant.eleven_or_one!
  end

  def player_turn
    loop do
      choice = hit_or_stay_choice
      hit_and_add_total(player) if choice == '1'
      check_for_eleven(player)
      clear_screen
      cards_screen
      break if player.busted? || choice == '2'
    end
  end

  def dealer_turn
    count = 0
    puts "Dealers Turn.."
    until dealer.card_total >= 17
      count += 1
      hit_and_add_total(dealer)
      check_for_eleven(dealer)
      puts count == 1 ? "\nThe Dealer Hits!" : "\nThe Dealer Hits AGAIN!!"
      puts "\nDealer Cards\n#{dealer.hidden_cards}"
    end
    puts "\n The Dealer stays" unless dealer.busted?
  end

  def tie_game
    puts "Its a tie"
  end

  def winner(participant)
    puts "#{participant} Wins The Game"
  end

  def busted(participant)
    puts "BUSTED! #{participant} loses.."
    new_line
  end

  def play_again?
    new_line
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

  def set_initial_cards
    clear_screen
    init_cards
  end

  def ready_screen
    loop do
      choice = start_choice
      next unless choice == "1"
      set_initial_cards
      check_for_eleven(player)
      check_for_eleven(dealer)
      cards_screen
      break
    end
  end

  def play_game
    player_turn
    return busted(player) if player.busted?
    new_line
    dealer_turn
    busted(dealer) if dealer.busted?

    evaluate_cards
    new_line
  end

  def start
    welcome_message
    loop do
      ready_screen
      play_game
      dealer_cards
      break unless play_again? == "1"
      reset_stats
      clear_screen
    end
    exit_screen
  end
end

Game.new.start
