require 'yaml'
require 'pry'

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
    return board.squares.keys[4] if open_fifth_square?(board)
  end

  def open_fifth_square?(brd)
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

  def display_welcome_message
    indent format(MESSAGES["welcome"])
  end

  def display_opponent
    new_line
    indent format(MESSAGES["opponent_announcement"], computer.name)
    new_line
  end

  def display_goodbye_message
    puts MESSAGES["thanks_for_playing"]
  end

  def clear
    system 'clear'
  end

  def display_result
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

  def display_board
    clear
    indent format(MESSAGES["player_markers"], human.marker, computer.name,
                  computer.marker)
    new_line
    board.draw_board
    new_line
  end
end

class Player
  attr_accessor :marker
  attr_reader :name

  def initialize(marker)
    @marker = marker
  end
end

class Computer < Player
  include ComputerStrategicMoves

  COMPUTER_NAMES = ["Chris Lee",
                    "Tony Robinson",
                    "Lex Fridman",
                    "Frodo Baggins"]

  def set_name
    @name = COMPUTER_NAMES.sample
  end

  def moves(hmn, cpu, board)
    board[place_piece(hmn, cpu, board)] = marker
  end
end

class Human < Player
  include Formatable

  def set_name
    alt_print MESSAGES["name?"]
    @name = gets.chomp
    new_line
    indent format(MESSAGES["hello_name"], name)
  end

  def moves(board)
    arrow format(MESSAGES["choose_square"], joinor(board))
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts MESSAGES["invalid_choice"]
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
      return squares.first.marker if count_markers(squares)
    end
    nil
  end

  private

  def count_markers(squares)
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
    clear
    start_screen
    start_game
    display_goodbye_message
  end

  private

  def start_screen
    display_welcome_message
    set_participant_names
    display_opponent
    choose_marker
    who_moves_first
    enter_and_begin
    display_board
  end

  def start_game
    loop do
      game_loop
      break unless play_again?
      clear
      who_moves_first
      reset
      enter_and_begin
      display_board
    end
  end

  def enter_and_begin
    indent MESSAGES["enter"]
    gets
    clear
  end

  def game_loop
    until board.someone_won? || board.full?
      alternate_turns
      clear_screen_and_display_board
    end
    display_result
  end

  def alternate_turns
    turns.shift ? human.moves(board) : computer.moves(human, computer, board)
  end

  def choose_marker
    loop do
      indent MESSAGES["marker_choice"]
      chosen_marker = gets.chomp.upcase
      next unless valid_marker?(chosen_marker)

      human.marker = chosen_marker
      computer.marker = human.marker == "X" ? "O" : "X"
      break
    end
  end

  def valid_marker?(marker)
    return true if marker == 'X' || marker == 'O'
    puts MESSAGES["invalid_marker"]
    false
  end

  def who_moves_first
    display_who_moves_first
    choice = gets.chomp
    if choice == '2'
      reverse_turns!
    else
      @turns
    end
  end

  def reverse_turns!
    @turns.shift
    @turns << false
  end

  def reset_turns
    @turns = (1..9).to_a.map(&:odd?)
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def play_again?
    puts MESSAGES["play_again"]
    answer = gets.chomp.downcase
    return true if answer == 'y'
    return false if answer == 'n'
    puts MESSAGES["invalid"]
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
