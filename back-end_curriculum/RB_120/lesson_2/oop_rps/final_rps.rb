require "yaml"
require 'pry'

MESSAGES = YAML.load_file('final_prompt.yml')

module SpecialMoves
  def r2d2
    [1, 3, 4, 5]
  end

  def hal
    [1, 3, 4, 5, 5]
  end

  def number5
    [1, 3, 4, 4, 5]
  end

  def chappie
    [1, 1, 2, 3, 5, 5]
  end

  def sonny
    [2, 3, 3]
  end
end

module RPSGameDisplay
  DIALOGUE = {  ["rock", "scissors"] => "ROCK crushes SCISSORS",
                ["rock", "lizard"] => "ROCK crushes LIZARD",
                ["paper", "rock"] => "PAPER covers ROCK",
                ["paper", "spock"] => "PAPER disproves SPOCK",
                ["scissors", "paper"] => "SCISSORS cuts PAPER",
                ["scissors", "lizard"] => "SCISSORS decapitates LIZARD",
                ["lizard", "paper"] => "LIZARD eats PAPER",
                ["lizard", "spock"] => "LIZARD poisons SPOCK",
                ["spock", "rock"] => "SPOCK vaporizes ROCK",
                ["spock", "scissors"] => "SPOCK smashes SCISSORS" }

  def display_dialogue(value)
    new_line
    indent_indent DIALOGUE[value]
    new_line
  end

  def clear_screen
    system "clear"
  end

  def display_goodbye_message
    puts "#{human.name} Thanks For Playing!"
  end

  def display_tie
    special_output("Even Round")
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

  def display_rounds
    new_line
    indent("Round: #{@round}")
  end

  def display_welcome_message
    puts "Hi #{human.name}"
    puts MESSAGES["welcome"]
    new_line
    indent_indent "Your opponent will be #{computer.name}"
    new_line
  end

  def display_round_dialogue
    keys = return_dialogue_keys
    display_dialogue(keys)
  end

  def display_round_winner
    return display_tie if check_winning_move == 'tie'
    winner = return_round_winner
    special_output("#{winner.name} won the round!")
  end

  def display_game_winner
    return tie_outline "Tie Game" if human.score == computer.score
    return display_winner(human) if human.score > computer.score
    display_winner(computer)
  end

  def display_winner(participant)
    winner_outline "#{participant.name} wins the game!"
  end

  def display_move_history
    clear_screen
    hmn_moves = human.move_history
    cpu_moves = computer.move_history

    puts "#{human.name}'s moves:   #{computer.name}'s moves:"
    new_line
    (0...hmn_moves.size).each do |i|
      indent "Round #{i + 1}: #{hmn_moves[i]} VS #{cpu_moves[i]}"
    end
    nil
  end
end

module Formatable
  def new_line
    puts
  end

  def special_output(value)
    puts " ---- #{value} -----"
  end

  def indent(value)
    puts "  #{value}"
  end

  def indent_indent(value)
    puts "    #{value}"
  end

  def winner_outline(value)
    bannerize(value, "*")
  end

  def tie_outline(value)
    bannerize(value, " ")
  end

  def bannerize(str, char)
    horizontals = "+=#{'=' * str.size}=+"
    new_line
    indent_indent horizontals
    indent_indent "#{char} #{' ' * str.size} #{char}"
    indent_indent "#{char} #{str} #{char}"
    indent_indent "#{char} #{' ' * str.size} #{char}"
    indent_indent horizontals
  end
end

class Move
  VALUES = {  1 => 'rock',
              2 => 'paper',
              3 => 'scissors',
              4 => 'lizard',
              5 => 'spock' }

  WINNING_MOVES = {  'rock' => ['lizard', 'scissors'],
                     'scissors' => ['paper', 'lizard'],
                     'paper' => ['rock', 'spock'],
                     'lizard' => ['spock', 'paper'],
                     'spock' => ['rock', 'scissors'] }

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    @value.capitalize
  end

  def equal?(other)
    self == other
  end

  def greater?(other)
    self > other
  end

  protected

  def >(other)
    WINNING_MOVES[value].include?(other.value)
  end

  def ==(other)
    value == other.value
  end
end

class Player
  attr_reader :name, :move, :score, :move_history

  include Formatable

  def initialize
    set_name
    @move_history = []
    @score = 0
  end

  def add_to_history(move)
    @move_history << move
  end

  def increment_score
    self.score += 1
  end

  def reset_moves
    self.move_history = []
  end

  def reset_score
    self.score = 0
  end

  private

  attr_writer :name, :move_history, :move, :score
end

class Human < Player
  def choice
    choice = nil
    valid_keys = Move::VALUES.keys
    loop do
      new_line
      puts MESSAGES["make_choice"]
      choice = gets.chomp.to_i
      break if valid_keys.include?(choice)
      puts MESSAGES["invalid_choice"]
    end
    self.move = Move.new(Move::VALUES[choice])
  end

  private

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
    name.empty? || name.match?(/[0-9|\s]/)
  end
end

class Computer < Player
  extend SpecialMoves

  def choice
    computer_value = Computer.send(name.downcase).sample
    self.move = Move.new(Move::VALUES[computer_value])
  end

  private

  def set_name
    self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number5"].sample
  end
end

class RPSGame
  def initialize
    @human = Human.new
    @computer = Computer.new
    @round = 1
  end

  def play
    clear_screen
    display_welcome_message
    loop do
      start_game
      display_game_winner
      break clear_screen unless play_again?
      reset_stats
      clear_screen
    end
    display_goodbye_message
  end

  private

  include Formatable
  include RPSGameDisplay

  def check_winning_move
    return "tie" if human.move.equal?(computer.move)
    human.move.greater?(computer.move)
  end

  def return_round_winner
    check_winning_move ? human : computer
  end

  def return_dialogue_keys
    hmn = human.move.value
    cpu = computer.move.value

    check_winning_move ? [hmn, cpu] : [cpu, hmn]
  end

  def add_moves(participant)
    my_move = participant.move
    participant.add_to_history(my_move)
  end

  def valid_rounds?(input)
    if input.match?(/[A-Za-z]/) || input.empty? || input.to_i.zero?
      puts MESSAGES["valid_number"]
      return true
    end
    false
  end

  def total_rounds
    display_ask_for_rounds
    loop do
      input = gets.chomp
      next display_ask_for_rounds if valid_rounds?(input)
      clear_screen
      return input
    end
  end

  def play_again?
    loop do
      new_line
      puts MESSAGES["another_game?"]
      answer = gets.chomp
      return true if answer.downcase == "y"
      return false if answer.downcase == "n"
      puts MESSAGES["invalid_input"]
    end
  end

  def track_wins
    return if check_winning_move == 'tie'
    check_winning_move ? human.increment_score : computer.increment_score
  end

  def hand_choice
    human.choice
    computer.choice
  end

  def game_stats
    display_move_history
    display_round_dialogue
    display_round_winner
    display_score
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
      game_stats
      increment_round
    end
  end

  attr_accessor :human, :computer, :round
end

RPSGame.new.play
