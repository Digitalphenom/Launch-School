require "yaml"

MESSAGES = YAML.load_file('final_prompt.yml')

module SpecialMoves
  def self.r2d2
    ["rock", "scissors", "lizard", "spock"].sample
  end

  def self.hal
    ["rock", "scissors", "lizard", "spock", "spock"].sample
  end

  def self.number5
    ["rock", "scissors", "lizard", "lizard", "spock"].sample
  end

  def self.chappie
    ["rock", "rock", "scissors", "lizard", "spock", "spock"].sample
  end

  def self.sonny
    ["scissors", "lizard", "lizard"].sample
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

  attr_reader :value

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

  def >(other_move)
    rock_wins?(other_move) ||
      paper_wins?(other_move) ||
      scissors_wins?(other_move) ||
      lizard_wins?(other_move) ||
      spock_wins?(other_move)
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

  def choice(round)
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
    self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number5"].sample
  end

  def choice
    self.move = Move.new(SpecialMoves.send(name.downcase))
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
    @winner = nil
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

  def check_winning_move
    return @winner = 'tie' if human.move.value == computer.move.value
    @winner = human.move > computer.move
  end

  def display_winner_and_score
    check_winning_move()
    return display_tie() if @winner == 'tie'

    if @winner
      special_output("#{human.name} WON!")
      self.human_score += 1
    else
      special_output("#{computer.name} WON!")
      self.computer_score += 1
    end
    display_score()
  end

  def display_tie
    special_output("Its a tie!")
    display_score()
  end

  def add_moves
    human.add_to_moves(human.name, human.move.value)
    computer.add_to_moves(computer.name, computer.move.value)
  end

  def display_game_winner
    return special_output "Its a tie!" if human_score == computer_score
    if human_score > computer_score
      special_output "#{human.name} wins the game!"
    else
      special_output "#{computer.name} wins the game!"
    end
  end

  def display_move_history
    puts "#{human.name}'s Moves:"
    p human.all_moves.values.first
    new_line
    puts "#{computer.name}'s Moves:"
    p computer.all_moves.values.first
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
    human.choice(round)
    computer.choice
  end

  def display_stats
    display_move_history
    display_current_moves
    display_winner_and_score
  end

  def start_game
    display_ask_for_rounds
    total = (total_rounds.to_i + 1)
    loop do
      make_choice(round)
      add_moves
      display_stats
      self.round += 1
      break if round == (total)
    end
  end

  def reset_stats
    self.round = 1
    self.human_score = 0
    self.computer_score = 0
  end

  def core_game
    loop do
      start_game
      display_game_winner
      break unless play_again?
      reset_stats
    end
  end

  def play
    display_welcome_message
    core_game
    display_goodbye_message(human)
  end

  protected

  attr_accessor :human, :computer, :human_score, :computer_score, :round
end

RPSGame.new.play
