
class Animal
  def speak
    "Hello!"
  end
end

class Dog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

pepper = Dog.new("Pepper")
soup = Cat.new

puts pepper.speak
puts soup.speak