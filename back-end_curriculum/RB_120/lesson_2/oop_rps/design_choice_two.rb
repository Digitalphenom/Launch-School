# class Move
#   VALUES = ["rock", "paper", "scissors"]
# 
#   def initialize(value)
#     @value = value
#   end
# 
#   def scissors?
#     @value == "scissors"
#   end
# 
#   def rock?
#     @value == "rock"
#   end
# 
#   def paper?
#     @value == "paper"
#   end
# 
#   def >(other_move)
#     (rock? && other_move.scissors?) ||
#       (paper? && other_move.rock?) ||
#       (scissors? && other_move.paper?)
#   end
# 
#   def <(other_move)
#     (scissors? && other_move.rock?) ||
#       (rock? && other_move.paper?) ||
#       (paper? && other_move.scissors?)
#   end
# 
#   def to_s
#     @value
#   end
# end
# 
# class Player
#   attr_accessor :move, :name
# 
#   def initialize
#     set_name
#   end
# end
# 
# class Human < Player
#   def set_name
#     n = ""
#     loop do
#       puts "Whats Your Name?\n"
#       n = gets.chomp
#       break unless n.empty?
#       puts "Sorry, must enter a value!"
#     end
#     self.name = n
#   end
# 
#   def choose
#     choice = nil
#     loop do
#       puts "Please choose rock, paper or scissors:"
#       choice = gets.chomp
#       break if Move::VALUES.include?(choice)
#       puts "Sorry, invalid choice."
#     end
#     self.move = Move.new(choice)
#   end
# end
# 
# class Computer < Player
#   def set_name
#     self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
#   end
# 
#   def choose
#     self.move = Move.new(Move::VALUES.sample)
#   end
# end
# 
# class RPSGame
#   attr_accessor :human, :computer, :human_score, :computer_score
# 
#   def initialize
#     @human = Human.new
#     @computer = Computer.new
#     @human_score = 0
#     @computer_score = 0
#   end
# 
#   def display_welcome_message
#     puts "Welcome to Rock, Paper, Scissors!"
#   end
# 
#   def display_goodbye_message
#     puts "Thanks for playing Rock, Paper, Scissors!. Bye!"
#   end
# 
#   def display_moves
#     puts "#{human.name} choose #{human.move}"
#     puts "#{computer.name} chose #{computer.move}"
#   end
# 
#   def display_winner
#     if human.move > computer.move
#       puts "#{human.name} won!"
#       @human_score += 1
#     elsif human.move < computer.move
#       puts "#{computer.name} won!"
#       @computer_score += 1
#     else
#       puts "Its a tie!"
#     end
#     puts
#   end
# 
#   def display_game_winner
#     if @human_score > @computer_score
#       puts "#{human.name} wins the game!"
#     elsif @human_score < @computer_score
#       puts "#{computer.name} wins the game!"
#     else
#       puts "Its a tie!"
#     end
#   end
# 
#   def display_round(round)
#     puts "Round: #{round}"
#   end
# 
#   def display_score
#     puts "human_score: #{human_score} computer_score: #{computer_score}"
#   end
# 
#   def play_again?
#     answer = nil
#     loop do
#       puts "Would you like to play again? (y/n)"
#       answer = gets.chomp
#       break if ["y", "n"].include?(answer.downcase)
#       puts "Sorry, must be y or n."
#     end
#     return true if answer == "y"
#     false
#   end
# 
#   def play
#     display_welcome_message
#     round = 1
# 
#     loop do
#       loop do
#         display_round(round)
#         human.choose
#         computer.choose
#         display_moves
#         display_winner
#         display_score
#         round += 1
#         break if round == 10
#       end
#       display_game_winner
#       break unless play_again?
#     end
#     display_goodbye_message
#   end
# end
# 
# RPSGame.new.play
# 
# 
# # This version is better in the sense that it organizes functionality to its # respective classes as opposed to a general purpose class. This is done by # introducing the specialized classes Human and Computer from where specialized # behavior stems from.
# 
# # A downside to this approach could be that if we introduce additional players, # each new player now requires a new specialized class of its own. If we were to # have a total of 10 different players, thats alot of code to write when we could # have used a general purpose Player class to generalize common behavior. # Although each player inherits from the Player class. Player is simply # initializing the set_name method but its not being utilized in a general way, # which means that the behavior would need to be re-defined for each additional # new player.
# 
# # The primary advantage of this refactor is similar to the previous. Namely, it # reduces redundancy by simplifying code logic. In this specific case we leverage # the ability of classes to define a comparison method so that instead of # manually defining each comparisons logic (before refactor) we can simply # compare each chosen move with one another. I cant think of a disadvantage to # this second approach because its already reducing the redundancy of code while # keeping the overall program working. However, we do make the code longer # because in order to get that to work we must define a Move class.
#