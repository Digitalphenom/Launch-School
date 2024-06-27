=begin

  □ Players
    ﹥ attacker
        blue shirt
          □ Run
          □ Shoot ball
          □ lob
        
    ﹥ midfielder
        blue shirt
          □ Run
          □ Shoot ball
          □ pass
    ﹥ defender
        blue shirt
          □ Run
          □ Shoot ball
          □ block
    ﹥ goalkeep
        white & blue stripes shirt
          □ Run
          □ Shoot ball
  □ Referee
    □ Color shirt
     ﹥ black
    □ Whistle
=end

require 'pry'

module Runable
	def run
	    'Running'
	end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Players
	attr_reader :color, :able
	include Runable

	def initialize(color, able)
	    @color = color
	    @able = able
	end	

	def shoot
	    'Shooting ball'
	end

	def ability
	    able + ' Ball'
	end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Referee
	attr_reader :color
	include Runable	

	def initialize
	  @whistle = true
	  @color = 'Black'
	end

	def run
	  super + " & Whistling"
  end

end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

all_players = [attacker = Players.new('Blue', 'Lobbing'),
midfielder = Players.new('Blue', 'Passing'),
defender = Players.new('Blue', 'Stealing'),
goalkeeper = Players.new('Blue & White Stripes', 'Blocking'),
referee = Referee.new,
]

all_players.each do |player|
  puts "\n#{player.class}"
  puts  "Attributes #{player.color} Shirt"
  puts "Behaviors: #{player.run }, #{player.shoot rescue "" }"
  puts "Special Ability: #{player.ability rescue "N/A"} "
end