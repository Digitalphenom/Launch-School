
module Swimmable
  def swim
    "Im swimming!"
  end
end

class Animal; end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable
end

sparky = Dog.new
neemo  = Fish.new
paws   = Cat.new

p sparky.swim                 # => I'm swimming!
p neemo.swim                  # => I'm swimming!
#paws.swim                   # => NoMethodError: undefined method `swim' for #<Cat:0x007fc453152308>