class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end

  def greet

  end

end

name = "Fluffy"
fluffy = Pet.new(name)
puts fluffy.name # => "FLUFFY"

puts fluffy # "My name is FLUFFY"
puts fluffy.name # "FLUFFY"
puts fluffy.greet # fluffy

=begin
this code here defines a class named Pet, along with the getter method name, an initialize method that sets the initial state of the instance variable @name to the attribute of a string argument. We then define a to_s method which begins by calling mutating `upcase!` on the `@name` instance variable and then a string output of `"My name is"` interpolating `@name` into the string as an uppercase name, our to_s method will override the native to_s method when we call `puts`.  

Finally, when we create an instance of `Pet` and pass `fluffy` as an argument then capture the instance to the local variable `fluffy`, we call the `puts` method on a call to `name` on the `fluffy` instance which will output `Fluffy` because 
=end



class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end

end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name # => 42
puts name
puts fluffy.name
puts name


# Further exploration
# this code here passes `name` by value to the `Pet` class where its converted to a string the `42` and assigned to the `@name` instance variable inside the `initialize` method. The value that `@name` references is distinct from the value that `name` in the main scope references. When we call `name` on the `fluffy` instance to access the `@name` value it does not trigger a call to `to_s` and instead outputs the value `42` directly. On line 20, when we call `puts` on `name` we access the integer `43`. Line 21 & 22 repeats this process outputing the string `42` and then the integer `43`. None of these calls to `puts` trigger the `to_s` method because they are not called on an `object instance`.
