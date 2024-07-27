class Dog
  def speak
    "Bark!"
  end

  def swim
    "Swimming"
  end
  
end

class Bulldog < Dog
  def swim
    "Can't Swim!"
  end
end

teddy = Dog.new
bull = Bulldog.new

puts teddy.speak
puts teddy.swim
puts bull.swim