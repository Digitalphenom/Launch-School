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

  def indent(text)
    puts "  #{text}"
  end

  def indent_indent(text)
    puts "    #{text}"
  end

  def wrap_text(text)
    text.each_line { |line|  indent_indent line }
  end

  def self.bannerize(text, char)
    horizontals = "+=#{'=' * text.size}=+"
    new_line
    indent_indent horizontals
    indent_indent "#{char} #{' ' * text.size} #{char}"
    indent_indent "#{char} #{text} #{char}"
    indent_indent "#{char} #{' ' * text.size} #{char}"
    indent_indent horizontals
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

module TTTGameDisplay
  def display_who_moves_first
    indent_indent format(MESSAGES["who_first"], human.name, computer.name)
    new_line
    puts format(MESSAGES["press_option"], human.name, computer.name)
  end

  def display_welcome_message
    puts format(MESSAGES["welcome"])
  end

  def display_opponent
    new_line
    puts format(MESSAGES["opponent_announcement"], computer.name)
    new_line
  end

  def display_goodbye_message
    puts MESSAGES["thanks_for_playing"]
  end

  def clear
    system 'clear'
  end

  def display_choose_unmarked
    puts format(MESSAGES["choose_square"], board.unmarked_keys.join(', '))
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts MESSAGES["human_won"]
    when computer.marker
      puts MESSAGES["computer_won"]
    else
      puts MESSAGES["tie"]
    end
  end

  def display_play_again
    puts MESSAGES["play_again"]
    puts
  end

  def display_board
    puts format(MESSAGES["player_markers"], human.marker, computer.name, computer.marker)
    new_line
    board.draw_board
    new_line
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
module Moveable
  def cpu_places_piece!(human, computer)
    square = nil

    Board::WINNING_LINES.each do |line|
      square = attack_or_defend(line, human, computer)
      break if square
    end
    square || fifth_square_or_random()
  end

  def attack_or_defend(line, hmn, cpu)
    if attack_square?(line, cpu) || defend_square?(line, hmn)
      return attack_or_defend_line(line).keys.first
    end
    nil
  end

  def attack_or_defend_line(line)
    @squares.select do |k, v|
      line.include?(k) && v.marker == " "
    end
  end

  def fifth_square_or_random
    @squares[5].marker == " " ? find_fifth_square() : unmarked_keys.sample
  end

  def attack_square?(line, computer)
    count_square?(line, computer)
  end

  def defend_square?(line, human)
    count_square?(line, human)
  end

  def count_square?(line, player)
    @squares.values_at(*line).select do |sqr|
      sqr.marker == player.marker
    end.count == 2
  end

  def find_fifth_square
    squares.keys[4]
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class Player
  attr_accessor :marker
  attr_reader :name

  def initialize(marker)
    @marker = marker
  end
end

class Computer < Player
  COMPUTER_NAMES = ["Chris Lee",
                    "Tony Robinson",
                    "Martha Stewart",
                    "Donald"]

  def set_name
    @name = COMPUTER_NAMES.sample
  end
end

class Human < Player
  def set_name
    print MESSAGES["name?"]
    @name = gets.chomp
    puts format(MESSAGES["hello_name"], name)
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # colums
                  [[1, 5, 9], [3, 5, 7]]

  include Moveable

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw_board
    puts '         |       |'
    puts "      #{@squares[1]}  |   #{@squares[2]}   |  #{@squares[3]}"
    puts '         |       |'
    puts '   ------+-------+------'
    puts '         |       |'
    puts "      #{@squares[4]}  |   #{@squares[5]}   |  #{@squares[6]}"
    puts '         |       |'
    puts '   ------+-------+------'
    puts '         |       |'
    puts "      #{@squares[7]}  |   #{@squares[8]}   |  #{@squares[9]}"
    puts '         |       |'
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

  def someone_won?
    !!winning_marker
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # returns winning marker or nil
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
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

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
  attr_reader :board, :human, :computer

  include Formatable
  include TTTGameDisplay

  def initialize
    @board = Board.new
    @human = Human.new("?")
    @computer = Computer.new("?")
    @turns = (1..9).to_a.map(&:odd?)
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?

      clear_screen_and_display_board
    end
    display_result
  end

  def choose_marker
    loop do
      puts MESSAGES["marker_choice"]
      n = gets.chomp.upcase
      next unless validate_marker(n)

      human.marker = n
      computer.marker = human.marker == "X" ? "O" : "X"
      break
    end
  end

  def validate_marker(n)
    unless n == 'X' || n == 'O'
      puts MESSAGES["invalid_marker"]
      return false
    end
    true
  end

  def who_moves_first
    display_who_moves_first
    who_moves_first_choice
  end

  def who_moves_first_choice
    choice = gets.chomp
    whos_turn(choice)
  end

  def whos_turn(choice)
    choice == '2' ? toggle_turn! : @turns
  end

  def toggle_turn!
    @turns.shift
    @turns << false
  end

  def current_player_moves
    turns.shift ? human_moves : computer_moves
  end

  def reset_turns
    @turns = (1..9).to_a.map(&:odd?)
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    display_choose_unmarked
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      
      puts MESSAGES["invalid_choice"]
    end
    board[square] = human.marker
  end

  def computer_moves
    board[computer_piece()] = computer.marker
  end

  def computer_piece
    board.cpu_places_piece!(human, computer)
  end

  def play_again?
    answer = ''
    loop do
      puts MESSAGES["play_again"]
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)

      puts MESSAGES["invalid"]
    end
    answer == 'y'
  end

  def reset
    board.reset
    reset_turns
    clear_screen_and_display_board
  end

  def set_participant_names
    computer.set_name
    human.set_name
  end

  def play
    clear
    start_screen
    start_game
    display_goodbye_message
  end

  def start_screen
    display_welcome_message
    set_participant_names
    display_opponent
    choose_marker
    who_moves_first
    display_board
  end

  def start_game
    loop do
      player_move
      break unless play_again?
      reset
      display_play_again
      who_moves_first
    end
  end

  private

  attr_accessor :turns
end

TTTGame.new.play

