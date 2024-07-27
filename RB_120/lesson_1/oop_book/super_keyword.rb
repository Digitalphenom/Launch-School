
class Animal
  def speak
    "Hello!"
  end
end

class Dog < Animal
  def speak
    super + " from Dog class"
  end
end

class Cat < Animal
end

pepper = Dog.new
soup = Cat.new

puts pepper.speak
puts soup.speak