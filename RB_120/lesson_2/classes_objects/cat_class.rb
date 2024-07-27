module Walkable
  def walk
    puts "Lets go for a walk!"
  end
end

class Cat
  include Walkable

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new("Soup")
kitty.greet
kitty.walk

kitty.name = "Torta"
kitty.greet

