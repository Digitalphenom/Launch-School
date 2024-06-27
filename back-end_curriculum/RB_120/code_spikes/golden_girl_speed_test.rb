## GOLDEN GIRLS SPIKE
# The girls live in a house with an address of 6151 Richmond Street Miami, FL. There are four inhabitants of the house:
# - Dorothy Zbornak
# - Blanche Deveraux
# - Rose Nylund
# - Sofia Petrillo
# All of the girls are American, except for Sofia-- she's Italian. All the girls work, except for Sofia. All of them are widows, except for Dorothy.
# - Only Dorothy (stays home on Saturday evenings.)
# - Only Rose has a (long-term boyfriend.)
# - Only Blanche (dates younger men.)
# - All of the girls are over 50.
# - Dorothy has an ex-husband by the name of Stan Zbornak.


class Home
  attr_reader :address

  def initialize
    @address = "6151 Richmond Street Miami, FL"
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class GoldenGirls
  attr_reader :nationality, :marriage_status, :work_status, :age, :home

  def initialize
    @home = Home.new
    @nationality = "American"
    @marriage_status = "Widowed"
    @work_status = "Working"
    @age = "50+"
  end

  def to_s
    "\n#{name}\nAge: #{age}\nAddress: #{home.address}\nNationality: #{nationality}\nMarriage Status: #{marriage_status}\nWork-Status: #{work_status}\nInteresting Fact: #{unique_detail}\n=================="
  end

end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class Dorothy < GoldenGirls
  attr_reader :unique_detail, :name

  def initialize
    super
    @name = "Dorothy Zbornak"
    @marriage_status = "Divorced from: Stan Zbornak"
    @unique_detail = "stays home on Saturday evenings."
  end
end

class Sofia < GoldenGirls
  attr_reader :unique_detail, :name

  def initialize
    super
    @name = "Sofia Petrillo"
    @work_status = "Not-Working"
  end
end

class Rose < GoldenGirls
  attr_reader :unique_detail, :name 

  def initialize
    super
    @name = "Rose Nylund"
    @nationality = "Italian"
    @unique_detail = "Long term boyfriend"
  end
end

class Blanche < GoldenGirls
  attr_reader :unique_detail, :name

  def initialize
    super
    @name = "Blanche Deveraux"
    @unique_detail = "dates younger men."
  end
end

[Blanche.new, Rose.new, Sofia.new, Dorothy.new].each do |girl|
  puts girl
end