
require 'pry'
class MortalKombat
  attr_reader :player1, :player2

  def initialize(players)
    p1, p2 = players
    @player1 = Player.new(p1)
    @player2 = Player.new(p2)
  end

  def to_s
    "*********************************************
            FIGHT! FIGHT!\n           #{player1.name} VS #{player2.name}
*********************************************\n#{display_player_stats}"
  end

  def display_player_stats
    "\nPlayer1: #{player1.name}\nHealth: #{player1.health}\nCostume:#{player1.costume_style}\nSpecial Move: #{player1.special_move}\nBasic Moves:\n#{player1.basic_moves}\n
Player2: #{player2.name}\nHealth: #{player2.health}\nCostume:#{player2.costume_style}\nSpecial Move: #{player2.special_move}\nBasic Moves:\n#{player1.basic_moves}"
  end

end

module BasicMovable
  def punch
    'punch'
  end

  def kick
    'kick'
  end

  def block
    'block'
  end

  def basic_moves
    [punch, kick, block].join("\n").upcase
  end
end

module FlyAble
  def fly_moves
    'Fly Through The Air'
  end
end

module FireAble
  def fire_moves
    'Set Stuff On Fire'
  end
end

class Player
  attr_reader :name, :health ,:costume_style, :special_move

  include Movable

  def initialize(name)
    @name = name
    @health = 100
    @player_type = human_or_god
    @costume_style, @special_move  = costume_style_and_special_ability
  end

  def human_or_god
    case name.downcase
    when 'raiden' then 'God'
    else
      'Human'
    end
  end

  def costume_style_and_special_ability
    case name.downcase
      when 'kitana' then ['Has Fans', 'Throws Fans For 15 Damage']
      when 'raiden' then ['Very Large Hat', 'Shoots Lightings For 25 Damage']
      when 'liu kang' then ['Has No Shirt', 'Fly\'s Through Air For 72 Damage']
      when 'jax' then ['Metal Arms', 'Pound\'s Ground For 63 Damage']
    end
  end

end

class PlayerScreen
  CHARACTERS = ['Raiden', 'Liu Kang', 'Jax', 'Kitana']

  attr_reader :start_game

  def initialize
    @start_game = MortalKombat.new([CHARACTERS.sample,  CHARACTERS.sample])
  end

end

game1 = PlayerScreen.new
puts game1.start_game

