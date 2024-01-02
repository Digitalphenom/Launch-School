class Cat
  attr_reader :name, :count
  @@count = 0
  def initialize
    @name = "Cat"
    @@count += 1
  end

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def personal_greeting
    puts "Hello! My name is #{name}"
  end

  def self.total
    @@count
  end

end

# class Cat
#   def self.speak
#     puts "Meow!"
#   end
# end
# 
# Cat.speak
puts

kitty1 = Cat.new
kitty2 = Cat.new

p Cat.total