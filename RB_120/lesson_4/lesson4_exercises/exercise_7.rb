class Cat 
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

cat = Cat.new("feeline")
puts cat # => Cat:0100xx
#cat.make_one_year_older

# self refers to the instance object that the make_one_year_older method is called on.



class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

Hello.hi


class Hello
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end