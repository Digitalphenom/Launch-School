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

module Runable
  def run
    'Running'
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Players
  attr_reader :color
  include Runable

  def initialize
    @color = 'Blue'
  end

  def shoot
    'Shooting ball'
  end

  def ability
    'Ball'
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Attacker < Players
  def ability
    'Lobbing ' + super
  end
end

class MidFielder < Players
  def ability
    'Passing ' + super
  end
end

class Defender < Players
  def ability
    'Stealing ' + super
  end
end

class GoalKeeper < Players
  attr_reader :color

  def initialize
    @color = 'White & Blue Stripes'
  end

  def ability
    'Blocking ' + super
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
    super + "& Whistling"
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

players_referee = [
  Attacker.new,
  MidFielder.new,
  Defender.new,
  GoalKeeper.new,
  Referee.new
]

players_referee.each do |player|
  puts "\n#{player.class}"
  puts  "Attributes #{player.color} Shirt"
  puts "Behaviors: #{player.run }, #{player.shoot rescue "" }"
  puts "Special Ability: #{player.ability rescue "N/A"} "
endsd.f,km 