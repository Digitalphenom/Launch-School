require "pry"
require "yaml"

MESSAGES = YAML.load_file('final_prompt.yml')

module SpecialMoves
  def self.r2d2
    @r2d2 = ["rock", "scissors", "lizard", "spock"].sample
  end

  def self.hal
    @hal = ["rock", "scissors", "lizard", "spock", "spock"].sample
  end

  def self.number5
    @number5 = ["rock", "scissors", "lizard", "lizard", "spock"].sample
  end

  def self.chappie
    @chappie = ["rock", "rock", "scissors", "lizard", "spock", "spock"].sample
  end

  def self.sonny
    @sonny = ["scissors", "lizard", "lizard"].sample
  end
end

module Banerable
  class Banner
    attr_reader :message, :center

    def initialize(message)
      @message = message.to_s
      @center = "-" * (message.to_s.size + 2)
    end

    def to_s
      [horizontal_rule, message_line, horizontal_rule].join("\n")
    end

    private

    def empty_line
      "| #{message.size} |"
    end

    def horizontal_rule
      "+#{center}+"
    end

    def message_line
      "| #{message} |"
    end
  end
end

module Formatable
  def new_line
    puts
  end

  def special_output(n)
    puts " ---- #{n} -----"
  end

  def output(n)
    puts n.to_s.upcase
  end

  def indent(n)
    puts "  #{n}"
  end
end

class Move
  VALUES = { 1 => "rock", 2 => "paper", 3 => "scissors", 4 => "lizard", 5 =>
"spock" }
  include SpecialMoves
  include Formatable

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == "scissors"
  end

  def rock?
    @value == "rock"
  end

  def paper?
    @value == "paper"
  end

  def lizard?
    @value == "lizard"
  end

  def spock?
    @value == "spock"
  end

  # Player Wins

  def rock_wins?(other_move)
    (rock? && other_move.scissors?) || (rock? && other_move.lizard?)
  end

  def paper_wins?(other_move)
    (paper? && other_move.rock?) || (paper? && other_move.spock?)
  end

  def scissors_wins?(other_move)
    (scissors? && other_move.paper?) || (scissors? && other_move.lizard?)
  end

  def lizard_wins?(other_move)
    (lizard? && other_move.spock?) || (lizard? && other_move.paper?)
  end

  def spock_wins?(other_move)
    (spock? && other_move.rock?) || (spock? && other_move.scissors?)
  end

  # Player Loses

  def rock_loss?(other_move)
    (rock? && other_move.paper?) || (rock? && other_move.spock?)
  end

  def paper_loss?(other_move)
    (paper? && other_move.lizard?) || (paper? && other_move.scissors?)
  end

  def scissors_loss?(other_move)
    (scissors? && other_move.rock?) || (scissors? && other_move.spock?)
  end

  def lizard_loss?(other_move)
    (lizard? && other_move.spock?) || (lizard? && other_move.paper?)
  end

  def spock_loss?(other_move)
    (spock? && other_move.lizard?) || (spock? && other_move.paper?)
  end

  def >(other_move)
    rock_wins?(other_move) ||
      paper_wins?(other_move) ||
      scissors_wins?(other_move) ||
      lizard_wins?(other_move) ||
      spock_wins?(other_move)
  end

  def <(other_move)
    scissors_loss?(other_move) ||
      lizard_loss?(other_move) ||
      paper_loss?(other_move) ||
      spock_loss?(other_move) ||
      rock_loss?(other_move)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :name, :all_moves, :move

  include Formatable

  def initialize
    set_name
    @all_moves = {}
  end

  def add_to_moves(player, move)
    all_moves[player] = [] if all_moves[player].nil?
    all_moves[player] << move
  end

  def to_s
    @all_moves
  end
end

class Human < Player
  def set_name
    name = ""
    loop do
      puts "Whats Your Name?\n"
      name = gets.chomp
      break unless valid_name?(name)
      puts MESSAGES["valid_name?"]
    end
    self.name = name
  end

  def valid_name?(name)
    name.empty? || name.match?(/[0-9]/)
  end

  def valid_size?(choice)
    choice.to_s.size == 1
  end

  def choose(round)
    choice = nil
    loop do
      indent("Round: #{round}")
      new_line
      puts MESSAGES["make_choice"]
      choice = gets.chomp
      break if valid_size?(choice) && Move::VALUES.keys.include?(choice.to_i)
      puts MESSAGES["invalid_choice"]
    end
    self.move = Move.new(Move::VALUES[choice.to_i])
  end
end

class Computer < Player
  def set_name
    self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
  end

  def choose
    case name
    when "R2D2" then self.move = Move.new(SpecialMoves.r2d2)
    when "Hal" then self.move = Move.new(SpecialMoves.hal)
    when "Chappie" then self.move = Move.new(SpecialMoves.chappie)
    when "Sonny" then self.move = Move.new(SpecialMoves.sonny)
    when "Number 5" then self.move = Move.new(SpecialMoves.number5)
    end
  end
end

class RPSGame
  include Formatable

  def initialize
    @human = Human.new
    @computer = Computer.new
    @human_score = 0
    @computer_score = 0
    @round = 1
  end

  def display_welcome_message
    puts "Hi #{human.name}"
    puts MESSAGES["welcome"]
    new_line
  end

  def display_goodbye_message(player)
    puts "#{player.name} Thanks For Playing!"
  end

  def display_current_moves
    puts "#{human.name} choose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner_and_score
    if human.move > computer.move
      special_output("#{human.name} WON!")
      @human_score += 1
    elsif human.move < computer.move
      special_output("#{computer.name} WON!")
      @computer_score += 1
    else
      special_output("Its a tie!")
    end
    display_score
  end

  def add_moves
    human.add_to_moves(human.name, human.move)
    computer.add_to_moves(computer.name, computer.move)
  end

  def display_game_winner
    if @human_score > @computer_score
      special_output "#{human.name} wins the game!"
    elsif @human_score < @computer_score
      special_output "#{computer.name} wins the game!"
    else
      special_output "Its a tie!"
    end
  end

  def initialize_banner(moves)
    puts Banerable::Banner.new(moves)
  end

  def display_move_history
    puts "User Moves:"
    human.all_moves.values.flatten.each { |moves| initialize_banner(moves) }
    new_line
    puts "Computer Moves:"
    computer.all_moves.values.flatten.each { |moves| initialize_banner(moves) }
    new_line
  end

  def display_score
    new_line
    indent "Human Score: #{human_score} Computer Score: #{computer_score}"
  end

  def display_ask_for_rounds
    indent MESSAGES["round?"]
  end

  def valid_rounds?(input)
    if input.match?(/[A-Za-z]/)
      puts MESSAGES["valid_number"]
      return true
    end
    false
  end

  def total_rounds
    input = ""

    loop do
      input = gets.chomp
      next display_ask_for_rounds if valid_rounds?(input)
      break
    end
    input
  end

  def play_again?
    answer = nil
    loop do
      puts MESSAGES["another_game?"]
      answer = gets.chomp
      break if ["y", "n"].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end
    return true if answer == "y"
    false
  end

  def make_choice(round)
    human.choose(round)
    computer.choose
  end

  def display_stats
    display_move_history
    display_current_moves
    display_winner_and_score
  end

  def start_game
    display_ask_for_rounds
    total = total_rounds
    loop do
      make_choice(round)
      add_moves
      display_stats
      self.round += 1
      break if round == (total.to_i + 1)
    end
  end

  def play
    display_welcome_message
    start_game
    display_game_winner
    RPSGame.new.play if play_again?
    display_goodbye_message(human)
  end

  protected

  attr_accessor :human, :computer, :human_score, :computer_score, :round
end

RPSGame.new.play
