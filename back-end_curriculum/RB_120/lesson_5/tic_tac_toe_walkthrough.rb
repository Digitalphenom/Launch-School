=begin
 Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns in marking a square. The first player to mark 3 squares in a row wins

 Nouns: board, player, square, grid
 Verbs: play, mark

▣ Board
▣ Square
▣ Player
  □ mark
  □ play

=end

# It is beest to access a method instead of directly accessing instance variables so we would access the method directly.

require "pry"

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # colums
                [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new}
  end

  def draw_board
    puts "         |       |"
    puts "      #{@squares[1]}  |   #{@squares[2]}   |  #{@squares[3]}"
    puts "         |       |"
    puts "   ------+-------+------"
    puts "         |       |"
    puts "      #{@squares[4]}  |   #{@squares[5]}   |  #{@squares[6]}"
    puts "         |       |"
    puts "   ------+-------+------"
    puts "         |       |"
    puts "      #{@squares[7]}  |   #{@squares[8]}   |  #{@squares[9]}"
    puts "         |       |"
    puts ""
  end

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
    (1..9).each { |key| @squares[key] = Square.new}
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if count_markers(squares)
        return squares.first.marker
      end
    end
    nil
  end

  private 

  def count_markers(squares)
    if squares.collect(&:marker).count("X") == 3
      squares.collect(&:marker).count("X") 
    elsif squares.collect(&:marker).count("O") == 3
      squares.collect(&:marker).count("O")
    end
  end
  
end

class Square 
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
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
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer
  attr_accessor :turns

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @turns = (1..9).to_a.map { |num| num.odd? ? true : false}
  end

  def toggle_turn(choice)
    @turns.shift
    @turns << false
  end

  def whos_turn(choice)
    choice == "2" ? shift_turn(choice) : @turns
  end

  def display_who_moves_first
    puts "      Who goes first?"
    puts "Press: 1 for Human | 2 for Computer"
  end

  def move_choice
    choice = gets.chomp
    toggle_turn(choice)
  end

  def reset_turns
    @turns = (1..9).to_a.map { |num| num.odd? ? true : false}
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
  end

  def display_goodbye_message
    puts "Thanks for playing!"
  end

  def clear
    system "clear"
  end

  def clear_screen_and_display_board
    clear()
    display_board()
  end

  def human_moves
    puts "Chose a square between #{board.unmarked_keys.join(", ")}:"
    square = nil
    loop do 
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
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
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "Its a tie!"
    end
  end

  def play_again?
    answer = ""
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end
    answer == "y"
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
    puts "Let's play again"
    puts
  end

  def current_player_moves
    turns.shift ? human_moves : computer_moves
  end

  def play
    clear
    display_welcome_message
    display_who_moves_first
    move_choice
    display_board

    loop do
      loop do 
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
      display_who_moves_first
      clear_screen_and_display_board

    end
    display_goodbye_message
  end
end

# Start Game
TTTGame.new.play







