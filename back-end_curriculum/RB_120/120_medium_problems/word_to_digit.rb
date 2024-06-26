=begin
Number Guesser Part 1
Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:

⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
Write a game that begins at 7 when you instantite a new `GuessingGame` object and decrements the count by 1 after each guess. When the amount of guesses hits 0 the game ends. Each guess will have a set of consequences. 

Invalid => Too low, too high, OutofRange
Valid => Correct Number
  ▣ The guessing numbers will be from 1-100
  ▣ The correct number should be known but hidden to the user.
  ▣ Each number should be validated against the valid range and correct number
  ▣ There should be a set of Outputs to the screen for every actions
    □ You have X guesses remaining << Dynamic
    □ Enter a number between 1 and 100
    □ You enetered an invalid number
    □ Your guess is too low
    □ Your guess is too high
    □ That's the number!!
    □ You have no more guesses. You lost!
    
    ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

count = 7
correct_num = X

You have X guesses remaining << Dynamic
User Input : X
Validated against correct num
Valid/Invalid output
decrement count -1
Repeat

⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DataStructures ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algo ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

▣ Set Counter to 7
▣ Generate correct number
▣ Execute looping mechanism
  □ You have X guesses remaining
  □ Get User Input
  □ Validated against correct num
  □ Output Valid/Invalid Message
  □ Decrement count -1
  □ check if count is equal to 1
    ﹥ false Repeat cycle
    ﹥ true end game message
=end

class GuessingGame
  attr_reader :player

  def initialize(player, low, high)
    @player = player
    @range = [low, high]
    @range_size = calculate_range(low, high)
  end

  def difficulty
      { 1 => (@range_size + 14),
        2 => (@range_size + 7),
        3 => (@range_size + 1),
      }
  end

  def play
    display_welcome_screen
    display_quit_option
    calculate_number
    choose_difficulty
    game_cycle
    check_counter
  end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  private

  def quit
    exit
  end

  def calculate_number
    low, high = [@range.first, @range.last]
    @winning_number = rand(low..high)
  end

  def calculate_range(low, high)
    size_of_range = high - low
    Math.log2(size_of_range).to_i
  end

  def choose_difficulty
    loop do 
      display_difficulty
      num = player.pick_number
      next if num > 4 || num <= 0
      break @counter = difficulty[num]
    end
  end

  def game_cycle
    while @counter > 0
      puts
      puts "You have #{@counter} guesses remaining"
      display_enter_valid_num
      chosen_number = player.pick_number
      quit if chosen_number == -555
      break display_winner if winning_number?(chosen_number)
      next display_out_of_range if chosen_number > @range.last || chosen_number < @range.first
      high_or_low(chosen_number)
      @counter -= 1
    end
  end

  def output(message)
    puts(message)
  end

  def check_counter
    display_looser if @counter == 0
  end

  def winning_number?(input)
    input.==(@winning_number)
  end

  def high_or_low(input)
    return display_too_high if input > @winning_number  
    display_too_low
  end

  def display_welcome_screen
    output "Welcome to the game #{player.name}!"
  end

  def display_too_high
    output 'Your guess is too high.'
  end

  def display_difficulty
    output "Choose a Game Difficulty"
    output "1: EASY 2: MEDIUM 3: HARD"
  end

  def display_too_low
    output 'Your guess is too low.'
  end

  def display_out_of_range
    output 'Invalid guess.'
  end

  def display_enter_valid_num
    output "Enter a number between #{@range.first} and #{@range.last}:"
  end

  def display_winner
    output "That's the number"
    output "You won!"
  end

  def display_looser
    output "You have no more guesses. You lost!"
  end

  def display_quit_option
    output "Enter -555 to exit game"
  end
end
# Do you think its a good idea to have a `Player` class?
# What methods and data should be part of it?
# How many player objects?
# Should you use inheritance, interface inheritance or collaborator objects?

# Adding a player class to the game as is might be overkill. The core game mechanics involves getting a user input, displaying the appropriate messages then decrementing the counter. Thats about it in terms of complexity. if the sole job of the player is to input values, is a seperate player class really necessary?
# However if we add additional functionality to the game ie..  entering a name, choosing the amount of rounds then it would make sense to add that additional class along with  objects collaboration to extend the functionality of the `Game` class.

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def pick_number
    gets.to_i
  end

end

joe = Player.new('Joe')

game = GuessingGame.new(joe, 501, 1500)
game.play

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.
# 
# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.
# 
# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.
# 
# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80
# 
# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

#You won!
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.
# 
# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.
# 
# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.
# 
# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.
# 
# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.
# 
# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.
# 
# You have 1 guess remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.
# 
# You have no more guesses. You lost!

