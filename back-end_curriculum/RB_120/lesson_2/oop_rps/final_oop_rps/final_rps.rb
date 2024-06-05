require "yaml"

MESSAGES = YAML.load_file('final_prompt.yml')

module SpecialMoves
  def augustus
    [1, 2, 3, 3, 4, 5, 5]
  end

  def nero
    [1, 5, 5, 5, 5]
  end

  def caligula
    [1, 1, 1, 4, 5, 5]
  end

  def marcus_aurelius
    [2, 3, 3, 4, 4]
  end

  def spartacus
    [3, 3, 3, 4, 5]
  end
end

module RPSGameDisplay
  def display_dialogue(keys)
    new_line
    keys = keys.join("_")
    indent_indent MESSAGES[keys]
    new_line
  end

  def display_pick_opponent
    new_line
    indent_indent "#{human.name}, enter a numeric value to pick your opponent"
    new_line
    puts MESSAGES["opponent_choice"]
  end

  def clear_screen
    system "clear"
  end

  def display_goodbye_message
    puts "#{human.name} Thanks For Playing!"
  end

  def display_tie
    special_output MESSAGES["even"]
  end

  def display_participant_scores
    new_line
    player_score(human)
    player_score(computer)
    new_line
  end

  def player_score(participant)
    print "  #{participant.name} Score: #{participant.score}"
  end

  def display_ask_for_rounds
    indent MESSAGES["round?"]
  end

  def display_rounds
    new_line
    indent("Round: #{@round} of #{@total_rounds}")
  end

  def display_welcome_message
    puts MESSAGES["welcome"]
    new_line
  end

  def display_opponent
    new_line
    indent_indent "#{human.name} your opponent will be #{computer.name}"
    new_line
  end

  def display_play_style
    cpu_name = computer.name.downcase
    description = MESSAGES[cpu_name]
    indent_indent "           PlayStyle"
    wrap_text(description)
    new_line
  end

  def display_on_first_round
    return unless @round == 1
    display_human_computer_name
    new_line
    indent MESSAGES["start"]
  end

  def display_round_dialogue
    keys = return_dialogue_keys
    display_dialogue(keys)
  end

  def display_round_winner
    return display_tie if check_winning_move == 'tie'
    winner = return_round_winner
    special_output("#{winner.name} won the round")
  end

  def display_game_winner
    return bannerize("Tie Game", " ") if human.score == computer.score
    return display_winner(human) if human.score > computer.score
    display_winner(computer)
  end

  def display_winner(participant)
    bannerize("#{participant.name} wins the game!", "*")
  end

  def display_human_computer_name
    puts "#{human.name}'s moves:   #{computer.name}'s moves:"
  end

  def display_move_history
    clear_screen
    hmn_moves = human.move_history
    cpu_moves = computer.move_history
    display_human_computer_name
    new_line
    (0...hmn_moves.size).each do |i|
      indent "Round #{i + 1}: #{hmn_moves[i]} vs #{cpu_moves[i]}"
    end
    nil
  end
end

module Formatable
  def new_line
    puts
  end

  def special_output(text)
    puts " ---- #{text} -----"
  end

  def indent(text)
    puts "  #{text}"
  end

  def indent_indent(text)
    puts "    #{text}"
  end

  def wrap_text(text)
    text.each_line { |line|  indent_indent line }
  end

  def bannerize(text, char)
    horizontals = "+=#{'=' * text.size}=+"
    new_line
    indent_indent horizontals
    indent_indent "#{char} #{' ' * text.size} #{char}"
    indent_indent "#{char} #{text} #{char}"
    indent_indent "#{char} #{' ' * text.size} #{char}"
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
      puts MESSAGES["hand_choice"]
      choice = gets.chomp.to_i
      break if valid_keys.include?(choice)
      puts MESSAGES["invalid_choice"]
    end
    self.move = Move.new(Move::VALUES[choice])
  end

  def set_name
    name = ""
    loop do
      print MESSAGES["your_name"]
      name = gets.chomp
      break unless valid_name?(name)
      puts MESSAGES["valid_name?"]
    end
    self.name = name.capitalize
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

  def set_player
    choice = gets.chomp.to_i
    self.name = MESSAGES[choice].capitalize
  end
end

class RPSGame
  def initialize
    @human = Human.new
    @computer = Computer.new
    @round = 1
  end

  def play
    start_screen
    loop do
      start_game
      display_game_winner
      break clear_screen unless play_again?
      new_opponent
      reset_stats
    end
    display_goodbye_message
  end

  private

  include Formatable
  include RPSGameDisplay

  def start_screen
    clear_screen
    display_welcome_message
    human.set_name
    pick_opponent
    your_opponent
  end

  def start_game
    total = (total_rounds.to_i + 1)
    until @round == total
      display_on_first_round
      display_rounds
      hand_choice
      add_human_computer_moves
      track_wins
      game_stats
      increment_round
    end
  end

  def new_opponent
    value = new_opponent?
    pick_opponent if value
    your_opponent if value
  end

  def your_opponent
    display_opponent
    display_play_style
  end

  def pick_opponent
    display_pick_opponent
    computer.set_player
  end

  def new_opponent?
    clear_screen
    loop do
      puts MESSAGES["opponent"]
      choice = gets.chomp
      return true if choice == 'y'
      return false if choice == 'n'
      puts MESSAGES["invalid_choice"]
    end
  end

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

  def valid_rounds?
    input = @total_rounds
    if input.match?(/[A-Za-z]/) || input.empty? || input.to_i.zero?
      puts MESSAGES["valid_number"]
      return true
    end
    false
  end

  def total_rounds
    display_ask_for_rounds
    loop do
      @total_rounds = gets.chomp
      next display_ask_for_rounds if valid_rounds?
      clear_screen
      return @total_rounds
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
    display_participant_scores
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

  attr_accessor :human, :computer, :round
end

RPSGame.new.play
