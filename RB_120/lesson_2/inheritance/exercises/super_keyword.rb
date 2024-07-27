class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Veh
  def initialize(year)
    super
    start_engine
  end
  
  def start_engine
    puts "Ready to go!"
  end
end

class Car < Vehicle
end

truck1 = Truck.new(1994)
puts truck1.year

# super no arguments syntax

class Vehicle
  def start_engine
    "Ready to go!"
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + " Drive #{speed}, please"
  end
end

truck1 = Truck.new
puts truck1.start_engine("slooow")
