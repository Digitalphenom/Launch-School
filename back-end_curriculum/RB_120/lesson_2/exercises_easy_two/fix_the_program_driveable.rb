module Driveable
  def self.drive # on the level of the module
    puts "hello"
  end
end

class Car
  def self.speed # => on the level of the class
  end
  include Driveable
end

::Driveable.drive
Car.drive

