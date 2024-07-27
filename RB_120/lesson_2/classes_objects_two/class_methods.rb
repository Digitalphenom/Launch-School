class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

kitty = Cat.new

Cat.generic_greeting # "Hello! I'm a cat!"
kitty.class.generic_greeting # "Hello! I'm a cat!"

=begin
the #class method when called on an object returns the class that object belongs to. If we then chain a call to the class method generic_greeting then its as if we are calling Cat.generic_greeting and will result in the class method being invoked

=end
