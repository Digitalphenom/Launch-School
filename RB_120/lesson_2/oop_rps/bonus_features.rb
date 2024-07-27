
# 
# 
# # ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Added bonus feature round + score # ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
# 
# 
# 
# 
# 
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
# #RPSGame.new.play




# ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Added bonus feature Spock◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

#  class Move
#    VALUES = ["rock", "paper", "scissors", "lizard", "spock"]
#  
#    def initialize(value)
#      @value = value
#    end
#  
#    def scissors?
#      @value == "scissors"
#    end
#  
#    def rock?
#      @value == "rock"
#    end
#  
#    def paper?
#      @value == "paper"
#    end
#  
#    def lizard?
#      @value == "lizard"
#    end
#  
#    def spock?
#      @value == "spock"
#    end
#  
#    def >(other_move)
#      (rock? && other_move.scissors?) ||
#        (rock? && other_move.lizard?) ||
#  
#        (paper? && other_move.rock?) ||
#        (paper? && other_move.spock?) ||
#  
#        (scissors? && other_move.paper?) ||
#        (scissors? && other_move.lizard?) ||
#  
#        (lizard? && other_move.spock?) ||
#        (lizard? && other_move.paper?) ||
#       
#        (spock? && other_move.rock?) ||
#        (spock? && other_move.scissors?)
#    end
#  
#    def <(other_move)
#      (scissors? && other_move.rock?) ||
#      (scissors? && other_move.spock?) ||
#    
#      (lizard? && other_move.rock?) ||
#      (lizard? && other_move.spock?) ||
#  
#      (paper? && other_move.lizard?) ||
#      (paper? && other_move.scissors?) ||
#  
#      (spock? && other_move.lizard?) ||
#      (spock? && other_move.paper?) ||
#  
#      (rock? && other_move.paper?) ||
#      (rock? && other_move.spock?) 
#    end
#  
#    # this is confusing because your mixing up what you choose to determine a #  win, and what the computer chooses to determine a win. Basically you need to #  clarify by organizing your chosen winners and the paired loser. Then repeat #  this for loosing move
#  
#    def to_s
#      @value
#    end
#  end
#  
#  class Player
#    attr_accessor :move, :name
#  
#    def initialize
#      set_name
#    end
#  end
#  
#  class Human < Player
#    def set_name
#      n = ""
#      loop do
#        puts "Whats Your Name?\n"
#        n = gets.chomp
#        break unless n.empty?
#        puts "Sorry, must enter a value!"
#      end
#      self.name = n
#    end
#  
#    def choose
#      choice = nil
#      loop do
#        puts "Please choose rock, paper, scissors, lizard or spock:"
#        choice = gets.chomp
#        break if Move::VALUES.include?(choice)
#        puts "Sorry, invalid choice."
#      end
#      self.move = Move.new(choice)
#    end
#  end
#  
#  class Computer < Player
#    def set_name
#      self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
#    end
#  
#    def choose
#      self.move = Move.new(Move::VALUES.sample)
#    end
#  end
#  
#  class RPSGame
#    attr_accessor :human, :computer, :human_score, :computer_score
#  
#    def initialize
#      @human = Human.new
#      @computer = Computer.new
#      @human_score = 0
#      @computer_score = 0
#    end
#  
#    def display_welcome_message
#      puts "Welcome to Rock, Paper, Scissors, LIZARD, SPOCK!"
#    end
#  
#    def display_goodbye_message
#      puts "Thanks for playing Rock, Paper, Scissors!. Bye!"
#    end
#  
#    def display_moves
#      puts "#{human.name} choose #{human.move}"
#      puts "#{computer.name} chose #{computer.move}"
#    end
#  
#    def display_winner
#      if human.move > computer.move
#        puts "#{human.name} won!"
#        @human_score += 1
#      elsif human.move < computer.move
#        puts "#{computer.name} won!"
#        @computer_score += 1
#      else
#        puts "Its a tie!"
#      end
#      puts
#    end
#  
#    def display_game_winner
#      if @human_score > @computer_score
#        puts "#{human.name} wins the game!"
#      elsif @human_score < @computer_score
#        puts "#{computer.name} wins the game!"
#      else
#        puts "Its a tie!"
#      end
#    end
#  
#    def display_round(round)
#      puts "Round: #{round}"
#    end
#  
#    def display_score
#      puts "human_score: #{human_score} computer_score: #{computer_score}"
#    end
#  
#    def play_again?
#      answer = nil
#      loop do
#        puts "Would you like to play again? (y/n)"
#        answer = gets.chomp
#        break if ["y", "n"].include?(answer.downcase)
#        puts "Sorry, must be y or n."
#      end
#      return true if answer == "y"
#      false
#    end
#  
#    def play
#      display_welcome_message
#      round = 1
#  
#      loop do
#        loop do
#          display_round(round)
#          human.choose
#          computer.choose
#          display_moves
#          display_winner
#          display_score
#          round += 1
#          break if round == 10
#        end
#        display_game_winner
#        break unless play_again?
#      end
#      display_goodbye_message
#    end
#  end
#  
#  RPSGame.new.play


# ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ add a class ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

#    class Move
#      VALUES = ["rock", "paper", "scissors", "lizard", "spock"]
#    
#      def initialize(value)
#        @value = value
#      end
#      def scissors?
#        @value == "scissors"
#      end
#    
#      def rock?
#        @value == "rock"
#      end
#    
#      def paper?
#        @value == "paper"
#      end
#    
#      def lizard?
#        @value == "lizard"
#      end
#    
#      def spock?
#        @value == "spock"
#      end
#    
#      def >(other_move)
#        (rock? && other_move.scissors?) ||
#          (rock? && other_move.lizard?) ||
#    
#          (paper? && other_move.rock?) ||
#          (paper? && other_move.spock?) ||
#    
#          (scissors? && other_move.paper?) ||
#          (scissors? && other_move.lizard?) ||
#    
#          (lizard? && other_move.spock?) ||
#          (lizard? && other_move.paper?) ||
#         
#          (spock? && other_move.rock?) ||
#          (spock? && other_move.scissors?)
#      end
#    
#      def <(other_move)
#        (scissors? && other_move.rock?) ||
#        (scissors? && other_move.spock?) ||
#      
#        (lizard? && other_move.rock?) ||
#        (lizard? && other_move.spock?) ||
#    
#        (paper? && other_move.lizard?) ||
#        (paper? && other_move.scissors?) ||
#    
#        (spock? && other_move.lizard?) ||
#        (spock? && other_move.paper?) ||
#    
#        (rock? && other_move.paper?) ||
#        (rock? && other_move.spock?) 
#      end
#    
#      def to_s
#        @value
#      end
#    end
#    
#    class Player
#      attr_accessor :move, :name
#    
#      def initialize
#        set_name
#      end
#    end
#    
#    class Paper < Player
#    end
#    
#    class Rock < Player
#    end
#    
#    class Scissors < Player
#    end
#    
#    class Spock < Player
#    end
#    
#    class Lizard < Player
#    end
#    
#    class Human < Player
#      def set_name
#        n = ""
#        loop do
#          puts "Whats Your Name?\n"
#          n = gets.chomp
#          break unless n.empty?
#          puts "Sorry, must enter a value!"
#        end
#        self.name = n
#      end
#    
#      def choose
#        choice = nil
#        loop do
#          puts "Please choose rock, paper, scissors, lizard or spock:"
#          choice = gets.chomp
#          break if Move::VALUES.include?(choice)
#          puts "Sorry, invalid choice."
#        end
#        self.move = Move.new(choice)
#      end
#    end
#    
#    class Computer < Player
#      def set_name
#        self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
#      end
#    
#      def choose
#        self.move = Move.new(Move::VALUES.sample)
#      end
#    end
#    
#    class RPSGame
#      attr_accessor :human, :computer, :human_score, :computer_score
#    
#      def initialize
#        @human = Human.new
#        @computer = Computer.new
#        @human_score = 0
#        @computer_score = 0
#      end
#    
#      def display_welcome_message
#        puts "Welcome to Rock, Paper, Scissors, LIZARD, SPOCK!"
#      end
#    
#      def display_goodbye_message
#        puts "Thanks for playing Rock, Paper, Scissors!. Bye!"
#      end
#    
#      def display_moves
#        puts "#{human.name} choose #{human.move}"
#        puts "#{computer.name} chose #{computer.move}"
#      end
#    
#      def display_winner
#        if human.move > computer.move
#          puts "#{human.name} won!"
#          @human_score += 1
#        elsif human.move < computer.move
#          puts "#{computer.name} won!"
#          @computer_score += 1
#        else
#          puts "Its a tie!"
#        end
#        puts
#      end
#    
#      def display_game_winner
#        if @human_score > @computer_score
#          puts "#{human.name} wins the game!"
#        elsif @human_score < @computer_score
#          puts "#{computer.name} wins the game!"
#        else
#          puts "Its a tie!"
#        end
#      end
#    
#      def display_round(round)
#        puts "Round: #{round}"
#      end
#    
#      def display_score
#        puts "human_score: #{human_score} computer_score: #{computer_score}"
#      end
#    
#      def play_again?
#        answer = nil
#        loop do
#          puts "Would you like to play again? (y/n)"
#          answer = gets.chomp
#          break if ["y", "n"].include?(answer.downcase)
#          puts "Sorry, must be y or n."
#        end
#        return true if answer == "y"
#        false
#      end
#    
#      def play
#        display_welcome_message
#        round = 1
#    
#        loop do
#          loop do
#            display_round(round)
#            human.choose
#            computer.choose
#            display_moves
#            display_winner
#            display_score
#            round += 1
#            break if round == 10
#          end
#          display_game_winner
#          break unless play_again?
#        end
#        display_goodbye_message
#      end
#    end
#    
#    RPSGame.new.play

# I dont immediatly see a way to seperate each player into its own class without introducing repetivie code. At the moment, weve defined a Move class that emulates the moving behavior of all players and contains the conditions for winning and losing. We also have a User & Computer class that inherit from a generic Player class. We collaborate our moves with  computer and player, passing the chosen hand to determine each players move. From there the winning and losing conditions are set and all that needs to be done is access the chosen values within a display winner method located in the RPSgame class.

# If we were to introduce separate classes for each player, we would unnecesarily complicate things. First, as far as I can see,  we would need to separate each winning condition to its respective class and then display each result by creating a conditional statements for each winner. This would be done by instantiating each player class and setting the winning n loosing conditions. This repeats the process we have already painstakingly created within the Move class.

# Now this is only as far as I can see. There may be an entirely different approach Im unaware of, but I dont see how I can repurpose each player as a separate class without introducing unnecessary complexity. Ill come back to this one to see If I can come up with an alternative approch.

# ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Keep track of moves ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

# If I need to keep track of each players moves and display them. I would reach for a hash where the key is the player, and the value is an array composed of moves. {user => [rock, paper, scissors], computer => [paper, scissors, spock]}
# As for whether I would create an entirely new class or use an existing one. Im thinking that if the Move class already contains data and behavior relating to allocating the proper moves. Why not give it the ability to keep track of past moves? Were already making use of the Human & Player classes within the RPGgame class. All we would need to do is invoke all_moves to insert and display each move.
# require "pry"
# 
# class Move
#   VALUES = ["rock", "paper", "scissors", "lizard", "spock"]
# 
# 
#   def initialize(value)
#     @value = value
#   end
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
#   def lizard?
#     @value == "lizard"
#   end
# 
#   def spock?
#     @value == "spock"
#   end
# 
#   def >(other_move)
#     (rock? && other_move.scissors?) ||
#       (rock? && other_move.lizard?) ||
# 
#       (paper? && other_move.rock?) ||
#       (paper? && other_move.spock?) ||
# 
#       (scissors? && other_move.paper?) ||
#       (scissors? && other_move.lizard?) ||
# 
#       (lizard? && other_move.spock?) ||
#       (lizard? && other_move.paper?) ||
#      
#       (spock? && other_move.rock?) ||
#       (spock? && other_move.scissors?)
#   end
# 
#   def <(other_move)
#     (scissors? && other_move.rock?) ||
#     (scissors? && other_move.spock?) ||
#   
#     (lizard? && other_move.rock?) ||
#     (lizard? && other_move.spock?) ||
# 
#     (paper? && other_move.lizard?) ||
#     (paper? && other_move.scissors?) ||
# 
#     (spock? && other_move.lizard?) ||
#     (spock? && other_move.paper?) ||
# 
#     (rock? && other_move.paper?) ||
#     (rock? && other_move.spock?) 
#   end
# 
#   def to_s
#     @value
#   end
# end
# 
# class Player
#   attr_accessor :move, :name, :all_moves
#   
#   def initialize
#     set_name
#     @all_moves = {}
#   end
# 
#   def add_name(player)
#     @all_moves[player] = [] if @all_moves[player].nil?
#   end
# 
#   def add_to_moves(player, move)
#     @all_moves[player] << move
#   end
# 
#   def to_s
#     @all_moves
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
#       puts "Please choose rock, paper, scissors, lizard or spock:"
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
#     puts "Welcome to Rock, Paper, Scissors, LIZARD, SPOCK!"
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
#   end
# 
#   def add_moves
#     human.add_name(human.name)
#     computer.add_name(computer.name)
#     human.add_to_moves(human.name, human.move)
#     computer.add_to_moves(computer.name, computer.move)
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
#   def display_all_moves
#     puts
#     puts "User moves:"
#      human.all_moves.values.each { |moves| puts moves}
#     puts
#     puts "Computer moves:"
#     computer.all_moves.values.each { |moves| puts moves}
#     puts
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
#         
#         display_moves
#         add_moves
#         display_all_moves
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

# ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ multiple personalities ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄





# require "pry"
# 
# module SpecialMoves
#   def self.r2d2
#     @r2d2 = ["rock", "scissors", "lizard", "spock"].sample
#   end
# 
#   def self.hal
#     @hal = ["rock", "scissors", "lizard", "spock", "spock"].sample
#   end
# 
#   def self.number5
#     @number5 = ["rock", "rock", "scissors", "scissors" "lizard", "lizard", # "lizard", "spock"].sample
#   end
# 
#   def self.chappie
#     @chappie = ["rock", "rock" "scissors", "lizard", "spock", "spock"].sample
#   end
# 
#   def self.sonny
#     @sonny = ["scissors", "lizard", "lizard", "lizard", "lizard"].sample
#   end
# end
# 
# class Move
#   VALUES = {1 => "rock", 2 => "paper", 3 => "scissors", 4 => "lizard", 5 => # "spock"}
#   include SpecialMoves
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
#   def lizard?
#     @value == "lizard"
#   end
# 
#   def spock?
#     @value == "spock"
#   end
# 
#   def >(other_move)
#     (rock? && other_move.scissors?) ||
#       (rock? && other_move.lizard?) ||
# 
#       (paper? && other_move.rock?) ||
#       (paper? && other_move.spock?) ||
# 
#       (scissors? && other_move.paper?) ||
#       (scissors? && other_move.lizard?) ||
# 
#       (lizard? && other_move.spock?) ||
#       (lizard? && other_move.paper?) ||
#      
#       (spock? && other_move.rock?) ||
#       (spock? && other_move.scissors?)
#   end
# 
#   def <(other_move)
#     (scissors? && other_move.rock?) ||
#     (scissors? && other_move.spock?) ||
#   
#     (lizard? && other_move.rock?) ||
#     (lizard? && other_move.spock?) ||
# 
#     (paper? && other_move.lizard?) ||
#     (paper? && other_move.scissors?) ||
# 
#     (spock? && other_move.lizard?) ||
#     (spock? && other_move.paper?) ||
# 
#     (rock? && other_move.paper?) ||
#     (rock? && other_move.spock?) 
#   end
# 
#   def to_s
#     @value
#   end
# end
# 
# class Player
#   attr_accessor :name, :all_moves
#   attr_writer :move
# 
#   def move
#     @move
#   end
#   
#   def initialize
#     set_name
#     @all_moves = {}
#   end
# 
#   def add_name(player)
#     @all_moves[player] = [] if @all_moves[player].nil?
#   end
# 
#   def add_to_moves(player, move)
#     @all_moves[player] << move
#   end
# 
#   def to_s
#     @all_moves
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
#       puts "Please choose: 1 for Rock | 2 for Paper | 3 for Scissors | 4 for # Lizard | 5 for Spock:"
#       choice = gets.chomp.to_i
#       #binding.pry
#       break if Move::VALUES.keys.include?(choice)
#       puts "Sorry, invalid choice."
#     end
#     self.move = Move.new(Move::VALUES[choice])
#   end
# end
# 
# class Computer < Player
#   def set_name
#     self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
#   end
# 
#   def choose
#     case self.name
#     when "R2D2" then self.move = Move.new(SpecialMoves.r2d2)
#     when "Hal" then self.move = Move.new(SpecialMoves.hal)
#     when "Chappie" then self.move = Move.new(SpecialMoves.chappie)
#     when "Sonny" then self.move = Move.new(SpecialMoves.sonny)
#     when "Number 5" then self.move = Move.new(SpecialMoves.number5)
#     end
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
#     puts "Welcome to Rock, Paper, Scissors, LIZARD, SPOCK!"
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
#   end
# 
#   def add_moves
#     human.add_name(human.name)
#     computer.add_name(computer.name)
#     human.add_to_moves(human.name, human.move)
#     computer.add_to_moves(computer.name, computer.move)
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
#   def display_all_moves
#     puts
#     puts "User moves:"
#      human.all_moves.values.each { |moves| puts moves}
#     puts
#     puts "Computer moves:"
#     computer.all_moves.values.each { |moves| puts moves}
#     puts
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
#         add_moves
#         display_all_moves
#         display_winner
#         display_score
#         round += 1
#         break if round == 10
#       end
#       display_game_winner
#       break unless play_again?
#       round = 1
#       self.human_score = 0
#       self.computer_score = 0
#     end
#     display_goodbye_message
#   end
# end
# 
# RPSGame.new.play


# ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Update rounds implementation ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄




#   
#   module SpecialMoves
#     def self.r2d2
#       @r2d2 = ["rock", "scissors", "lizard", "spock"].sample
#     end
#   
#     def self.hal
#       @hal = ["rock", "scissors", "lizard", "spock", "spock"].sample
#     end
#   
#     def self.number5
#       @number5 = ["rock", "rock", "scissors", "scissors" "lizard", "lizard", 
#   "lizard", "spock"].sample
#     end
#   
#     def self.chappie
#       @chappie = ["rock", "rock" "scissors", "lizard", "spock", "spock"].sample
#     end
#   
#     def self.sonny
#       @sonny = ["scissors", "lizard", "lizard", "lizard", "lizard"].sample
#     end
#   end
#   
#   class Move
#     VALUES = {1 => "rock", 2 => "paper", 3 => "scissors", 4 => "lizard", 5 => 
#   "spock"}
#     include SpecialMoves
#   
#     def initialize(value)
#       @value = value
#     end
#   
#     def scissors?
#       @value == "scissors"
#     end
#   
#     def rock?
#       @value == "rock"
#     end
#   
#     def paper?
#       @value == "paper"
#     end
#   
#     def lizard?
#       @value == "lizard"
#     end
#   
#     def spock?
#       @value == "spock"
#     end
#   
#     def >(other_move)
#       (rock? && other_move.scissors?) ||
#         (rock? && other_move.lizard?) ||
#   
#         (paper? && other_move.rock?) ||
#         (paper? && other_move.spock?) ||
#   
#         (scissors? && other_move.paper?) ||
#         (scissors? && other_move.lizard?) ||
#   
#         (lizard? && other_move.spock?) ||
#         (lizard? && other_move.paper?) ||
#        
#         (spock? && other_move.rock?) ||
#         (spock? && other_move.scissors?)
#     end
#   
#     def <(other_move)
#       (scissors? && other_move.rock?) ||
#       (scissors? && other_move.spock?) ||
#     
#       (lizard? && other_move.rock?) ||
#       (lizard? && other_move.spock?) ||
#   
#       (paper? && other_move.lizard?) ||
#       (paper? && other_move.scissors?) ||
#   
#       (spock? && other_move.lizard?) ||
#       (spock? && other_move.paper?) ||
#   
#       (rock? && other_move.paper?) ||
#       (rock? && other_move.spock?) 
#     end
#   
#     def to_s
#       @value
#     end
#   end
#   
#   class Player
#     attr_accessor :name, :all_moves
#     attr_writer :move
#   
#     def move
#       @move
#     end
#     
#     def initialize
#       set_name
#       @all_moves = {}
#     end
#   
#     def add_name(player)
#       @all_moves[player] = [] if @all_moves[player].nil?
#     end
#   
#     def add_to_moves(player, move)
#       @all_moves[player] << move
#     end
#   
#     def to_s
#       @all_moves
#     end
#   end
#   
#   class Human < Player
#     def set_name
#       n = ""
#       loop do
#         puts "Whats Your Name?\n"
#         n = gets.chomp
#         break unless n.empty?
#         puts "Sorry, must enter a value!"
#       end
#       self.name = n
#     end
#   
#     def choose
#       choice = nil
#       loop do
#         puts "Please choose: 1 for Rock | 2 for Paper | 3 for Scissors | 4 for #   Lizard | 5 for Spock:"
#         choice = gets.chomp.to_i
#         #binding.pry
#         break if Move::VALUES.keys.include?(choice)
#         puts "Sorry, invalid choice."
#       end
#       self.move = Move.new(Move::VALUES[choice])
#     end
#   end
#   
#   class Computer < Player
#     def set_name
#       self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
#     end
#   
#     def choose
#       case self.name
#       when "R2D2" then self.move = Move.new(SpecialMoves.r2d2)
#       when "Hal" then self.move = Move.new(SpecialMoves.hal)
#       when "Chappie" then self.move = Move.new(SpecialMoves.chappie)
#       when "Sonny" then self.move = Move.new(SpecialMoves.sonny)
#       when "Number 5" then self.move = Move.new(SpecialMoves.number5)
#       end
#     end
#   end
#   
#   class RPSGame
#     attr_accessor :human, :computer, :human_score, :computer_score
#     @@round = 1
#   
#     def initialize
#       @human = Human.new
#       @computer = Computer.new
#       @human_score = 0
#       @computer_score = 0
#     end
#   
#     def display_welcome_message
#       puts "Welcome to Rock, Paper, Scissors, LIZARD, SPOCK!"
#     end
#   
#     def display_goodbye_message
#       puts "Thanks for playing Rock, Paper, Scissors!. Bye!"
#     end
#   
#     def display_moves
#       puts "#{human.name} choose #{human.move}"
#       puts "#{computer.name} chose #{computer.move}"
#     end
#   
#     def display_winner
#       if human.move > computer.move
#         puts "#{human.name} won!"
#         @human_score += 1
#       elsif human.move < computer.move
#         puts "#{computer.name} won!"
#         @computer_score += 1
#       else
#         puts "Its a tie!"
#       end
#     end
#   
#     def add_moves
#       human.add_name(human.name)
#       computer.add_name(computer.name)
#       human.add_to_moves(human.name, human.move)
#       computer.add_to_moves(computer.name, computer.move)
#     end
#   
#     def display_game_winner
#       if @human_score > @computer_score
#         puts "#{human.name} wins the game!"
#       elsif @human_score < @computer_score
#         puts "#{computer.name} wins the game!"
#       else
#         puts "Its a tie!"
#       end
#     end
#   
#     def display_all_moves
#       puts
#       puts "User moves:"
#        human.all_moves.values.each { |moves| puts moves}
#       puts
#       puts "Computer moves:"
#       computer.all_moves.values.each { |moves| puts moves}
#       puts
#     end
#   
#     def display_round
#       puts "Round: #{@@round}"
#     end
#   
#     def display_score
#       puts "human_score: #{human_score} computer_score: #{computer_score}"
#     end
#   
#     def play_again?
#       answer = nil
#       loop do
#         puts "Would you like to play again? (y/n)"
#         answer = gets.chomp
#         break if ["y", "n"].include?(answer.downcase)
#         puts "Sorry, must be y or n."
#       end
#       return true if answer == "y"
#       false
#     end
#   
#     def play
#       display_welcome_message
#   
#       loop do
#         loop do
#           display_round
#           human.choose
#           computer.choose
#           display_moves
#           add_moves
#           display_all_moves
#           display_winner
#           display_score
#           @@round += 1
#           break if @@round == 10
#         end
#         display_game_winner
#         break unless play_again?
#         @@round = 1
#         self.human_score = 0
#         self.computer_score = 0
#       end
#       display_goodbye_message
#     end
#   end
#   
#   RPSGame.new.play


# ⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Add additional valid name checks ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

require "pry"

module SpecialMoves
  def self.r2d2
    @r2d2 = ["rock", "scissors", "lizard", "spock"].sample
  end

  def self.hal
    @hal = ["rock", "scissors", "lizard", "spock", "spock"].sample
  end

  def self.number5
    @number5 = ["rock", "rock", "scissors", "scissors" "lizard", "lizard", 
"lizard", "spock"].sample
  end

  def self.chappie
    @chappie = ["rock", "rock" "scissors", "lizard", "spock", "spock"].sample
  end

  def self.sonny
    @sonny = ["scissors", "lizard", "lizard", "lizard", "lizard"].sample
  end
end

class Move
  VALUES = {1 => "rock", 2 => "paper", 3 => "scissors", 4 => "lizard", 5 => 
"spock"}
  include SpecialMoves

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == "scissors"
  end

  def rock?
    @value == "rock"
  end

  def paper?
    @value == "paper"
  end

  def lizard?
    @value == "lizard"
  end

  def spock?
    @value == "spock"
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (rock? && other_move.lizard?) ||

      (paper? && other_move.rock?) ||
      (paper? && other_move.spock?) ||

      (scissors? && other_move.paper?) ||
      (scissors? && other_move.lizard?) ||

      (lizard? && other_move.spock?) ||
      (lizard? && other_move.paper?) ||
     
      (spock? && other_move.rock?) ||
      (spock? && other_move.scissors?)
  end

  def <(other_move)
    (scissors? && other_move.rock?) ||
    (scissors? && other_move.spock?) ||
  
    (lizard? && other_move.rock?) ||
    (lizard? && other_move.spock?) ||

    (paper? && other_move.lizard?) ||
    (paper? && other_move.scissors?) ||

    (spock? && other_move.lizard?) ||
    (spock? && other_move.paper?) ||

    (rock? && other_move.paper?) ||
    (rock? && other_move.spock?) 
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :name, :all_moves
  attr_writer :move

  def move
    @move
  end
  
  def initialize
    set_name
    @all_moves = {}
  end

  def add_name(player)
    @all_moves[player] = [] if @all_moves[player].nil?
  end

  def add_to_moves(player, move)
    @all_moves[player] << move
  end

  def to_s
    @all_moves
  end
end

class Human < Player
  def set_name
    name = ""
    loop do
      puts "Whats Your Name?\n"
      name = gets.chomp
      break if valid_name?(name)
      puts "Sorry, must enter a value!"
    end
    self.name = name
  end

  def valid_name?(name)
    (name.empty? || name.match?(/[0-9]/)) ? false : true
  end

  def choose
    choice = nil
    loop do
      puts "Please choose: 1 for Rock | 2 for Paper | 3 for Scissors | 4 for Lizard | 5 for Spock:"
      choice = gets.chomp.to_i
      break if Move::VALUES.keys.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(Move::VALUES[choice])
  end
end

class Computer < Player
  def set_name
    self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
  end

  def choose
    case self.name
    when "R2D2" then self.move = Move.new(SpecialMoves.r2d2)
    when "Hal" then self.move = Move.new(SpecialMoves.hal)
    when "Chappie" then self.move = Move.new(SpecialMoves.chappie)
    when "Sonny" then self.move = Move.new(SpecialMoves.sonny)
    when "Number 5" then self.move = Move.new(SpecialMoves.number5)
    end
  end
end

class RPSGame
  attr_accessor :human, :computer, :human_score, :computer_score
  @@round = 1

  def initialize
    @human = Human.new
    @computer = Computer.new
    @human_score = 0
    @computer_score = 0
  end

  def display_welcome_message
    puts "Hi #{human.name}"
    puts "Welcome to Rock, Paper, Scissors, LIZARD, SPOCK!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors!. Bye!"
  end

  def display_moves
    puts "#{human.name} choose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      @human_score += 1
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      @computer_score += 1
    else
      puts "Its a tie!"
    end
  end

  def add_moves
    human.add_name(human.name)
    computer.add_name(computer.name)
    human.add_to_moves(human.name, human.move)
    computer.add_to_moves(computer.name, computer.move)
  end

  def display_game_winner
    if @human_score > @computer_score
      puts "#{human.name} wins the game!"
    elsif @human_score < @computer_score
      puts "#{computer.name} wins the game!"
    else
      puts "Its a tie!"
    end
  end

  def display_all_moves
    puts
    puts "User moves:"
     human.all_moves.values.each { |moves| puts moves}
    puts
    puts "Computer moves:"
    computer.all_moves.values.each { |moves| puts moves}
    puts
  end

  def display_round
    puts "Round: #{@@round}"
  end

  def display_score
    puts "human_score: #{human_score} computer_score: #{computer_score}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ["y", "n"].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end
    return true if answer == "y"
    false
  end

  def play
    display_welcome_message

    loop do
      loop do
        display_round
        human.choose
        computer.choose
        display_moves
        display_winner
        add_moves
        display_all_moves
        display_score
        @@round += 1
        break if @@round == 10
      end
      display_game_winner
      break unless play_again?
      @@round = 1
      self.human_score = 0
      self.computer_score = 0
    end
    display_goodbye_message
  end
end

RPSGame.new.play