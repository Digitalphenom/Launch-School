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
  DIALOGUE = {  ["rock", "spock"] => "ROCK crushes SCISSORS",
                ["rock", "lizard"] => "ROCK crushes LIZARD",
                ["paper", "rock"] => "PAPER covers ROCK",
                ["paper", "spock"] => "PAPER disproves SPOCK",
                ["scissors", "paper"] => "SCISSORS cuts PAPER",
                ["scissors", "lizard"] => "SCISSORS decapitates LIZARD",
                ["lizard", "paper"] => "LIZARD eats PAPER",
                ["lizard", "spock"] => "LIZARD poisons SPOCK",
                ["spock", "rock"] => "SPOCK vaporizes ROCK",
                ["spock", "scissors"] => "SPOCK smashes SCISSORS" }

  def new_line
    puts
  end

  def special_output(n)
    puts " ---- #{n} -----"
  end

  def dialogue_output(value)
    new_line
    puts DIALOGUE[value]
  end

  def output(n)
    puts n.to_s.upcase
  end

  def indent(n)
    puts "  #{n}"
  end
end

class Move
  VALUES = {  1 => "rock",
              2 => "paper",
              3 => "scissors",
              4 => "lizard",
              5 => "spock" }

  include SpecialMoves

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
    @value.upcase
  end
end

class Player
  attr_reader :name, :all_moves, :move, :score

  include Formatable

  def initialize
    set_name
    @all_moves = []
    @score = 0
  end

  def add_to_all_moves(move)
    all_moves << move
  end

  def to_s
    "#{name}'s moves: #{@all_moves}"
  end

  def reset_moves
    self.all_moves = []
  end

  def reset_score
    self.score = 0
  end

  def increment_score
    self.score += 1
  end

  private

  attr_writer :name, :all_moves, :move, :score
end

class Human < Player
  def set_name
    name = ""
    loop do
      puts MESSAGES["your_name"]
      new_line
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

  def choice
    choice = nil
    loop do
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
    @round = 1
  end

  def clear_screen
    system "clear"
  end

  def display_goodbye_message
    puts "#{human.name} Thanks For Playing!"
  end

  def display_current_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def check_winning_move
    return 'tie' if human.move.value == computer.move.value
    human.move > computer.move
  end

  def round_winner
    hmn = human.move.value
    cpu = computer.move.value

    value1 = check_winning_move ? [hmn, cpu] : [cpu, hmn]
    value2 = check_winning_move ? "#{human.name} WON!" : "#{computer.name} WON!"
    [value1, value2]
  end

  def display_win_or_tie
    return display_tie if check_winning_move == 'tie'
    value, winner = round_winner
    dialogue_output(value)
    special_output(winner)
  end

  def display_tie
    special_output("Its a tie!")
  end

  def add_moves(participant)
    participant.add_to_all_moves(participant.move.value)
  end

  def display_game_winner
    return special_output "Its a tie!" if human.score == computer.score
    if human.score > computer.score
      special_output "#{human.name} wins the game!"
    else
      special_output "#{computer.name} wins the game!"
    end
  end

  def display_move_history
    clear_screen
    puts human
    new_line
    puts computer
    new_line
  end

  def display_score
    new_line
    print "  #{human.name} Score: #{human.score}"
    print "  #{computer.name} Score: #{computer.score}"
    new_line
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
    display_ask_for_rounds
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
      puts MESSAGES["invalid_input"]
    end
    clear_screen
    return true if answer == "y"
    false
  end

  def track_wins
    return if check_winning_move == 'tie'
    check_winning_move ? human.increment_score : computer.increment_score
  end

  def hand_choice
    human.choice
    computer.choice
  end

  def display_stats
    display_move_history
    display_current_moves
    display_win_or_tie
    display_score
  end

  def display_rounds
    indent("Round: #{@round}")
  end

  def add_human_computer_moves
    add_moves(human)
    add_moves(computer)
  end

  def reset_stats
    human.reset_score
    computer.reset_score
    computer.reset_moves
    human.reset_moves
    reset_rounds
  end

  def display_welcome_message
    puts "Hi #{human.name}"
    puts MESSAGES["welcome"]
    new_line
    puts "Your opponent will be #{computer.name}"
    new_line
  end

  def reset_rounds
    @round = 1
  end

  def increment_round
    @round += 1
  end

  def start_game
    total = (total_rounds.to_i + 1)
    until @round == total
      display_rounds
      hand_choice
      add_human_computer_moves
      track_wins
      display_stats
      increment_round
    end
  end

  def play
    clear_screen
    display_welcome_message
    loop do
      start_game
      display_game_winner
      break clear_screen unless play_again?
      reset_stats
    end
    display_goodbye_message
  end

  private

  attr_accessor :human, :computer, :round
end

RPSGame.new.play
