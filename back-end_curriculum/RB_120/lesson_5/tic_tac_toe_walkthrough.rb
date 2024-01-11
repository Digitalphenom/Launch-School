class Board
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
    if squares.collect(&:marker).count('X') == 3
      squares.collect(&:marker).count('X')
    elsif squares.collect(&:marker).count('O') == 3
      squares.collect(&:marker).count('O')
    end
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

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'.freeze
  COMPUTER_MARKER = 'O'.freeze

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @turns = (1..9).to_a.map { |num| num.odd? ? true : false }
  end

  def play
    clear
    main_game
    display_goodbye_message
  end

  private

  def main_game
    display_welcome_message
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

  def display_who_moves_first
    puts '      Who goes first?'
    puts 'Press: 1 for Human | 2 for Computer'
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
    @turns = (1..9).to_a.map { |num| num.odd? ? true : false }
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
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
    board[board.unmarked_keys.sample] = computer.marker
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
    puts "You're #{human.marker}. Computer is #{computer.marker}"
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

# Start Game
TTTGame.new.play
