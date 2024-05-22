require "pry"

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

  def cpu_places_piece!(human, computer)
    square = nil

    WINNING_LINES.each do |line|
      square = attack_or_defend(line, human, computer)
      break if square
    end
    square ? square : fifth_square_or_random()
  end

  def attack_or_defend(line, hmn, cpu)
    hsh = {}

    if attack_square?(line, cpu) || defend_square?(line, hmn)
      hsh = attack_or_defend_line(line) 
    end
    hsh.keys.first
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
    squares.collect(&:marker).count('X') == 3 || squares.collect(&:marker).count('O') == 3
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
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
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class Player
  attr_accessor :marker

  def initialize(marker)
    @marker = marker
  end
  
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class Computer < Player
  COMPUTER_NAMES = ["Chris Lee", "Tony Robinson", "Owen Cook", "Your Mother"].sample

  def name
    COMPUTER_NAMES
  end
end

class Human < Player
  attr_reader :name

  def set_human_name
    puts "What is your name?"
    @name = gets.chomp
    puts "Hey #{name} lets get started!"
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class TTTGame
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new("?")
    @computer = Computer.new("?")
    @turns = (1..9).to_a.map { |num| num.odd? }
  end

  def play
    clear
    main_game
    display_goodbye_message
  end

  def main_game
    display_welcome_message
    human.set_human_name
    choose_marker 
    display_who_moves_first_and_player_option
    display_board

    loop do
      player_move
      break unless play_again?

      reset
      display_play_again_message
      display_who_moves_first_and_player_option
    end
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
      puts 'Would you like to be X or O'
      n = gets.chomp.upcase
      next unless validate_marker(n)

      self.human.marker = n
      if human.marker == "X"
        self.computer.marker = "O"
      else
        self.computer.marker = "X"
      end
      break
    end
  end

  def validate_marker(n)
    unless n == 'X' || n == 'O'
      puts 'Please Enter a Valid Marker' 
      return false
    end
    true
  end

  def display_who_moves_first
    puts "      Who goes first #{human.name} or #{computer.name}?"
    puts
    puts "Press: 1 for #{human.name} | 2 for #{computer.name}"
  end

  def display_who_moves_first_and_player_option
    display_who_moves_first
    who_moves_first_choice
  end

  def who_moves_first_choice
    choice = gets.chomp
    whos_turn(choice)
  end

  def whos_turn(choice)
    choice == '2' ? toggle_turn : @turns
  end

  def toggle_turn
    @turns.shift
    @turns << false
  end

  def current_player_moves
    turns.shift ? human_moves : computer_moves
  end

  def reset_turns
    @turns = (1..9).to_a.map { |num| num.odd? }
  end

  def display_welcome_message
    puts "Hello#{human.name}, welcome to Tic Tac Toe!"
    puts "Your opponent today will be #{computer.name}"
  end

  def display_goodbye_message
    puts 'Thanks for playing!'
  end

  def clear
    system 'clear'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Chose a square between #{board.unmarked_keys.join(', ')}:"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)

      puts 'Sorry, that\'s not a valid choice.'
    end
    board[square] = human.marker
  end

  def computer_moves
      # This returns the positional square that we want to assign a marker to. The return value of get_computer_piece should be dynamic.
      # offensive
      # defensive
      # The fifth square
      # random
    board[get_computer_piece()] = computer.marker
  end

  def get_computer_piece
    board.cpu_places_piece!(human,computer)
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts 'You won!'
    when computer.marker
      puts 'Computer won!'
    else
      puts 'Its a tie!'
    end
  end

  def play_again?
    answer = ''
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w[y n].include?(answer)

      puts 'Sorry, must be y or n'
    end
    answer == 'y'
  end

  def display_board
    puts "You're #{human.marker}. #{computer.name} is #{computer.marker}"
    puts
    board.draw_board
    puts
  end

  def reset
    board.reset
    reset_turns
    clear_screen_and_display_board
  end

  def display_play_again_message
    puts 'Let\'s play again'
    puts
  end

  attr_accessor :turns
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

# Start Game
TTTGame.new.play
