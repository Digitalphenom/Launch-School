=begin
Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

▣ Create the class MyCar
▣ Allow user to define an instance variable
  □ Year, color, model
▣ Create an instance variable set to 0 that tracks current speed
▣ Create instance method that defines the following behavior:
  □ speed up, brake, shut off car

Add a class method to your MyCar class that calculates the gas mileage (i.e. miles per gallon) of any car.

Override the to_s method to create a user friendly print out of your object.

=end

class MyCar
  attr_accessor :color
  attr_reader :year, :model

  def self.calculate_gas_milage(miles, gallons)
    puts "Your miles per gallons is: #{miles / gallons} mpg"
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @vin = 0
  end

  def generate_vin
    11.times { @vin += @vin * 10 + ("0".."9").to_a.sample.to_i }
  end
  
  def to_s
    "Your car is a #{color}, #{year}, #{model} #{generate_vin}"
  end

  def speed_up(x)
    @speed += x
  end

  def change_color(input)
    self.color = input
  end

  def brake(x)
    @speed -= x
  end

  def current_speed
    puts "Your current speed is #{@speed} mph"
  end

  def shut_off(input)
    return "Vehicle is off" if input.include?("off") && @speed.zero?
    "Please turn off the vehicle"
  end

end

toyota = MyCar.new(2009, "Red", "Yaris")
puts toyota

MyCar.calculate_gas_milage(235, 10)
p toyota