class MortalKombat
  attr_reader :player1, :player2

  def initialize(players)
    @player1, @player2 = players
  end

  def to_s
    "*********************************************
            FIGHT! FIGHT!\n           #{player1.class} VS #{player2.class}
*********************************************\n#{display_player_stats}"
  end

  def display_player_stats
    "\nPlayer1: #{player1.class}\nHEALTH: #{player1.health}\nCostume:#{player1.costume_style}\nSpecial Move: #{player1.special_move}\nBasic Moves:\n#{player1.basic_moves}\n
Player2: #{player2.class}\nHEALTH: #{player2.health}\nCOSTUME:#{player2.costume_style}\nSpecial Move: #{player2.special_move}\nBasic Moves:\n#{player1.basic_moves}"
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

class PlayerRoster
  attr_reader :name, :health ,:costume_style, :special_move_damage

  include BasicMovable

  def initialize
    @health = 100
    @player_type = human_or_god
  end

  def human_or_god
    case self.class.to_s
    when 'raiden' then 'God'
    else
      'Human'
    end
  end
end

class Jax < PlayerRoster
  include FireAble

  def initialize
    super
    @costume_style = 'Metal Arms'
    @special_move_damage = 63
  end

  def special_move
    "Pound's Ground For #{special_move_damage} Damage"
  end
end

class LiuKang < PlayerRoster
  include FlyAble

  def initialize
    super
    @costume_style = 'Has No Shirt'
    @special_move_damage = 72
  end

  def special_move
    "Fly's Through Air For #{special_move_damage} Damage"
  end
end

class Raiden < PlayerRoster
  include FireAble

  def initialize
    super
    @costume_style = 'Very Large Hat'
    @special_move_damage = 25
  end
  def special_move
    "Shoots Lightings For #{special_move_damage} Damage"
  end
end

class Kitana < PlayerRoster
  include FlyAble

  def initialize
    super
    @costume_style = 'Has Fans'
    @special_move_damage = 15
  end

  def special_move
    "Throws Fans For #{special_move_damage} Damage"
  end
end


class PlayerScreen
  CHARACTERS = [Jax.new, LiuKang.new, Raiden.new, Kitana.new]

  attr_reader :start_game

  def initialize
    @start_game = MortalKombat.new([CHARACTERS.sample,  CHARACTERS.sample])
  end
end

game1 = PlayerScreen.new
puts game1.start_game

