# Ben and Alyssa are working on a vehicle management system. So far, they have created classes called Auto and Motorcycle to represent automobiles and motorcycles. After having noticed common information and calculations they were performing for each type of vehicle, they decided to break out the commonality into a separate class called WheeledVehicle. This is what their code looks like so far:

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency
  # This is essentially initializing without the `initialize` method. The difference is that the variables initializes to `nil`.
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
end
# Behavior defined with the `Moveable` module is common to ALL vehicles
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  endn

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Auto < WheeledVehicle
  puts 'se'
  puts "#{} skfjsdlkfj"

  def initializen
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
# Now Alan has asked them to incorporate a new type of vehicle into their system - a Catamaran defined as follows:

class SeaCraft
  include Moveable

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @num_propellers = num_propellers
    @num_hulls = num_hulls
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    # ... code omitted ...
  end

  def range
    @fuel_capacity * @fuel_efficiency + 10
  end

end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class Catamaran < SeaCraft;end
class MotorBoat < SeaCraft;end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

boat1 = MotorBoat.new(1, 1, 5, 25)
boat2 = CataMaran.new([5,6], 2, 5, 25)
boat1.range # 


# This new class does not fit well with the object hierarchy defined so far. Catamarans don't have tires. But we still want common code to track fuel efficiency and range. Modify the class definitions and move code into a Module, as necessary, to share code among the Catamaran and the wheeled vehicles.

# This example is actually a mixture of what ive seen. Up to this point ive tended to thought of using `interface inheritance` over `inheritance` in terms of related and unrelated classes. However this example uses a mixture of the two where we have a class hierarchy along with an unrelated class that still requires the behavior from a superclass. The unrelated class cannot inherit from the superclass that defines the behavior we need so the solution restructures the code so that the common behavior is moved into a module and included into the superclass and unrelated class. This makes sense because we cant leverage the behavior from the superclass because the `Catamaran` class cannot form a hierarchical relationship with `WheeledVehicle`.

# If this were a `Vehicle` superclass then my initial solution would be feasable 

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻Q2◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

# Given a Basic MotorBoat with a single propeller and hull. The rest of the behavior is similar to a Catamaran. Instances of MotorBoat dont need to specify hulls or propellers. Modify the vehicle class to incorporate these elements.

# ◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻Q3◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞
# Alter the class structure so that the `range` method adds an additional 10km for sea vehicles and leaves the land vehicles as is.

# To do this we would simply need to override the `range` instance method within the `Seacraft` superclass. When an instance of `Seacraft` invokes `range`, Ruby will first search in the class of the instance the method is called on (`Seacraft`) where it will find & invoke the redefined `range` instance method.

# My initial solution wrote the entire method from scratch but another option would be to use `super` to extend the functionality of the class by leveraging behavior from the `Moveable` module. ie :
# def range
#   super + 10
# end