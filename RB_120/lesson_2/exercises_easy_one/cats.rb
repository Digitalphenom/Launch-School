=begin
▣ define an additional parameter coat_color, along with its instance variable correspondent.
▣ define getter method
□ define to_s override method
  □ String interpolation
    "my cat #{name} is #{age} #{coat"
=end

class Pet
  attr_reader :name, :age, :color

  def initialize(name, age)
    @name = name
    @age = age
    @color = color
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{name} is #{age} years old and has #{color} fur."
  end
end

class Dog < Pet
  def to_s
    "My Dog #{name} is #{age} years old"
  end
end

pudding = Cat.new("Pudding", 7, "black and white")
butter = Cat.new("Butter", 10, "tan and white")
pepper = Dog.new("Peper", 2)

puts pudding
puts butter
puts pepper

# My cat pudding is 7 years old and has black and white fur.

# the downside of modifying the parameters in the initialize method of the Pet class is that we may want to only define colors for cats and leave name and age as a general application for pets. Meaning that if we had a Dog, we can  leave out its color coat attribute without having to manually modify the Pet class initialize method to make it work

# the reason why we can leave the initailzie method out of the Cat class is that Ruby will first search for a to_s method in the class it is called on. If it does not find one, it goes up the class hierarchy and looks for it there. This process repeats until the corresponding method is found or there are no more classes to look up and raises and error.