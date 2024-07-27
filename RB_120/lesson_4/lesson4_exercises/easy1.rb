
module Speed
    def self.go_fast
        'No'
    end

    def go_fast
        puts self
        puts "I am a #{self.class} and going super fast!!"
    end
end

class Car
    include Speed
    
    def go_slow
        puts 'I am safe and driving slow.'
    end
end

small_car = Car.new
small_car.go_fast
# This code outputs `Car` when it outputs the `go_fast` method because the method call to `#class` on `self` returns the class of the current object.

# In this example the `go_fast` instance method is mixed-into the `Car` class and then called on the `small_car` instance. Because of this `self` within the `go_fast` method refers to the instance of the class the method is called on. 

#<Car:0x000055909d95ece0>

# When the `#class` method is invoked on the current object it returns the class of that instance which in this case is `Car`.

# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻


class Fruit
    def initialize(name)
        name = name # This code here assigns the `name` attribute to a `name` local variable
    end
end

class Pizza
    def initialize(name)
        @name = name # This line here utilizes a `instance variable` delimited by a single `@` symbol.
    end
end

# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻

# The default return value of the `#to_s` method is a string representation of an object. I can consult my memory or Look at the ruby docs but really you can just test this out by instantiating an object and calling the `puts` method and see that it indeed returns a string representation of an object which comes in the form of a class name followed by an encoding id.

pizza = Pizza.new('Cheese')
puts pizza


# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻

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

# `self` on line 65 refers to a method invocation of the `writer` method `age=` because the expression `self.age += 1` is short hand for `self.age = age + 1` which evaluates the expression `age + 1` first then executes `self.age =` which is re-assignment. Since were updating the value of the `@age` instance variable and were doing so through the `writer` method. It is functionally required to prepend the `self` keyword to the `age` writer method.

# Ok so apparently the expression `self.age=` can be seen as independent from the whole ie invoking the writer method. `self` can still be seen as a component which refers to the current object even though it is still technically a method call to the `age=` writer method.

# In this scenerio `self` refers to the class of the class method itself which in this case is `Cat` because the class method is defined within the `Cat` class.


# To create a new instance of the `Bag` class we would call the `new` method on the `Bag` class, and provide the required arguments if neccessary, which would automatically trigger the `initialize` method and assign the objects initial state. A new instance is then created that can be assigned to a `local variable`.

class Bag
    def initialize(color, material)
        @color = color
        @material = material
    end
end

bag = Bag.new('red', 'Cordiroi')
p bag












