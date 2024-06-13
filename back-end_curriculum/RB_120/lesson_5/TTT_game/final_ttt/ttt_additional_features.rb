require 'yaml'

MESSAGES = YAML.load_file('ttt_prompt.yml')

module Formatable
  private

  def new_line
    puts
  end

  def special_output(text)
    puts " ---- #{text} -----"
  end

  def arrow(text)
    puts "=> #{text}"
  end

  def indent(text)
    puts "  #{text}"
  end

  def indent_indent(text)
    puts "    #{text}"
  end

  def alt_print(text)
    print "  #{text}"
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

module ComputerStrategicMoves
  def place_piece(human, computer, board)
    find_strategic_square(board, [computer, human]) ||
      attack_fifth_square_if_open(board) ||
      random_square(board)
  end

  private

  def find_strategic_square(board, players)
    players.each do |player|
      square = attack_or_defend_square(board, player)
      return square if square
    end
    nil
  end

  def attack_or_defend_square(board, player)
    Board::WINNING_LINES.each do |line|
      if two_in_a_line?(line, player, board)
        return first_open_square(line, board)
      end
    end
    nil
  end

  def two_in_a_line?(line, player, brd)
    brd.squares.values_at(*line).count do |sqr|
      sqr.marker == player.marker
    end == 2
  end

  def first_open_square(line, brd)
    brd.squares.select { |k, v| line.include?(k) && v.marker == " " }.keys.first
  end

  def attack_fifth_square_if_open(board)
    return board.squares.keys[4] if fifth_square_open?(board)
  end

  def fifth_square_open?(brd)
    brd.squares[5].marker == " "
  end

  def random_square(board)
    board.unmarked_keys.sample
  end
end

module TTTGameDisplay
  private

  def display_who_moves_first
    indent format(MESSAGES["who_first"], human.name, computer.name)
    new_line
    indent format(MESSAGES["press_option"], human.name, computer.name)
  end

  def display_welcome
    indent format(MESSAGES["welcome"])
  end

  def display_opponent
    new_line
    indent format(MESSAGES["opponent_announcement"], computer.name)
    new_line
  end

  def display_goodbye
    puts MESSAGES["thanks_for_playing"]
  end

  def clear_screen
    system 'clear'
  end

  def display_end_game_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      bannerize(MESSAGES["human_won"], "*")
    when computer.marker
      bannerize(MESSAGES["computer_won"], "X")
    else
      bannerize(MESSAGES["tie"], " ")
    end
    new_line
  end

  def display_play_again
    puts MESSAGES["play_again"]
    new_line
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def display_invalid
    puts MESSAGES["invalid"]
  end

  def display_press_enter
    indent MESSAGES["enter"]
  end

  def display_board
    clear_screen
    indent format(MESSAGES["player_markers"], human.marker, computer.name,
                  computer.marker)
    new_line
    board.draw_board
    new_line
  end

  def display_invalid_num
    indent MESSAGES["invalid_num"]
  end
end

module HumanDisplay
  private

  def display_choose_marker
    indent MESSAGES["marker_choice"]
  end

  def display_enter_name
    alt_print MESSAGES["name?"]
  end

  def display_welcome_name
    indent format(MESSAGES["hello_name"], name)
  end

  def display_invalid_marker
    puts MESSAGES["invalid_marker"]
  end

  def display_square_options(board)
    arrow format(MESSAGES["choose_square"], joinor(board))
  end

  def display_invalid_choice
    puts MESSAGES["invalid_choice"]
  end

  def display_invalid_name
    puts MESSAGES["invalid_name"]
  end
end

class Player
  attr_reader :name, :marker

  def initialize(marker)
    @marker = marker
  end

  def assign_marker(value)
    self.marker = value
  end

  def assign_name(name)
    self.name = name
  end

  private

  attr_writer :marker, :name
end

class Computer < Player
  include ComputerStrategicMoves

  COMPUTER_NAMES = ["Chris Lee",
                    "Tony Robinson",
                    "Lex Fridman",
                    "Frodo Baggins"]

  def set_name
    assign_name(COMPUTER_NAMES.sample)
  end

  def move(hmn, cpu, board)
    board[place_piece(hmn, cpu, board)] = marker
  end

  def choose_marker(opponent_choice)
    marker = opponent_choice == "X" ? "O" : "X"
    assign_marker(marker)
  end
end

class Human < Player
  include HumanDisplay
  include Formatable

  def set_name
    loop do
      display_enter_name
      name = gets.chomp
      next display_invalid_name if invalid_name?(name)
      assign_name(name)
      new_line
      display_welcome_name
      break
    end
  end

  def choose_marker
    loop do
      display_choose_marker
      chosen_marker = gets.chomp.upcase
      next display_invalid_marker unless valid_marker?(chosen_marker)
      assign_marker(chosen_marker)
      return marker
    end
  end

  def invalid_name?(name)
    name.empty? || name.match?(/[^\w\s]/) || name.size < 2
  end

  def valid_marker?(marker)
    marker == 'X' || marker == 'O'
  end

  def move(board)
    display_square_options(board)
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      display_invalid_choice
    end
    board[square] = marker
  end

  def joinor(board)
    str = board.unmarked_keys.join(', ')
    if str.size > 1
      str[-2] = ' or '
      return str
    end
    str
  end
end

class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # colums
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw_board
    puts '           |       |'
    puts "        #{@squares[1]}  |   #{@squares[2]}   |  #{@squares[3]}"
    puts '           |       |'
    puts '     ------+-------+------'
    puts '           |       |'
    puts "        #{@squares[4]}  |   #{@squares[5]}   |  #{@squares[6]}"
    puts '           |       |'
    puts '     ------+-------+------'
    puts '           |       |'
    puts "        #{@squares[7]}  |   #{@squares[8]}   |  #{@squares[9]}"
    puts '           |       |'
    puts
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.select { |_, sq| sq.unmarked? }.keys
  end

  def full?
    unmarked_keys.empty?
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_in_a_line?(squares)
    end
    nil
  end

  private

  def three_in_a_line?(squares)
    x = squares.collect(&:marker).count('X') == 3
    o = squares.collect(&:marker).count('O') == 3
    x || o
  end
end

class Square
  attr_accessor :marker

  INITIAL_MARKER = ' '.freeze

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class TTTGame
  include Formatable
  include TTTGameDisplay

  def initialize
    @board = Board.new
    @human = Human.new("?")
    @computer = Computer.new("?")
    @turns = (1..9).to_a.map(&:odd?)
  end

  def play
    clear_screen
    start_screen
    start_game
    display_goodbye
  end

  private

  def start_screen
    display_welcome
    set_participant_names
    display_opponent
    choose_your_markers
    who_moves_first
    enter_to_begin
    display_board
  end

  def start_game
    loop do
      game_loop
      break unless play_again?
      clear_screen
      who_moves_first
      reset
      enter_to_begin
      display_board
    end
  end

  def game_loop
    until board.someone_won? || board.full?
      alternate_turns
      clear_screen_and_display_board
    end
    display_end_game_result
  end

  def alternate_turns
    current_turn ? human.move(board) : computer.move(human, computer, board)
  end

  def current_turn
    turns.shift
  end

  def choose_your_markers
    human_choice = human.choose_marker
    computer.choose_marker(human_choice)
  end

  def who_moves_first
    loop do
      display_who_moves_first
      choice = gets
      next display_invalid_num unless valid_choice?(choice)
      return reverse_turns! if choice == '2'
      break
    end
  end

  def reverse_turns!
    @turns.shift
    @turns << false
  end

  def reset_turns
    @turns = (1..9).to_a.map(&:odd?)
  end

  def play_again?
    loop do
      display_play_again
      answer = gets.chomp.downcase
      return true if answer == 'y'
      return false if answer == 'n'
      display_invalid
    end
  end

  def enter_to_begin
    display_press_enter
    gets
    clear_screen
  end

  def valid_choice?(choice)
    choice.match?(/[1|2]/)
  end

  def reset
    board.reset
    reset_turns
  end

  def set_participant_names
    computer.set_name
    human.set_name
  end

  attr_accessor :turns
  attr_reader :board, :human, :computer
end

TTTGame.new.play
