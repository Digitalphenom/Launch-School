# Redo of exercises easy 3
class Greeting
    def greet(message)
        puts message
    end
end

class Hello < Greeting

    def self.hi
        hello = Hello.new
        hello.hi
    end

    def hi
        greet('Hello')
    end
end

class Goodbye < Greeting
    def bye
        greet('GoodBye')
    end
end

# Given the provided code what happens if:

hello = Hello.new
hello.hi

# If we instantiate a new `Hello` object and then `invoke` the `hi` instance method the return value will be `Hello` because Ruby  first searches for a corresponding method to execute within the class the method is called on. In this case the expression `hello.hi` invokes the `hi` method on an `instance` of the `Hello` class which defines the `hi` instance method that further invokes a `greet` instance method defined in the `Greeting` superclass. Ruby will first search in the class where the method is called, fail to find it, then search up the `inheritance hierarchy` and execute `greet` within the `Greeting` superclass.

# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻

hello = Hello.new
#hello.bye 

# In this scenerio we invoke `bye` on an instance of `Hello` which would return a `NoMethodError` because `bye` is not included in the `Hello` class's method lookup path. Ruby in this case searches in `Hello` and then `Greeting` and fails to find a corresponding method to execute. This behavior aligns with the `single inheritance` principle of `inheritance` which states that a subclass can inherit the behaviors from one direct `superclass`. Although `Goodbye` is part of the same `class hierarchy` that `Hello` is, they have no connection to one another from a `method lookup` perspective.

# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻def

# hello.greet

# This code here will raise an `ArgumentError` because when we call `greet` on an instance of `Hello` it will NOT find a corresponding method to execute in the `Hello` class. When it searches up the `inheritance hierarchy` it finds it in the `Greeting` superclass but it requires an `argument` which the expression `hello.greet` fails to provide.

# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻

hello.greet('Goodbye')

# This example provides the requires arguments and outs `'Goodbye'`.

# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻
puts
Hello.hi

# This code attempts to invoke the class method `hi` but a class method was never defined so a `NoMethodError` is raised. One way to fix this could be to define a class method then `instantiate` an instance of `Hello` within the class method and then invoke the `hi` method on that instance.


# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻

class Cat
    attr_accessor :type, :age

    def initialize(type)
        @type = type
        @age = 0
    end

    def make_one_year_older
        @age += 1
    end


    # the tricky part is wrapping my head around incrementing by one without invoking the writer method. `self` is Required when invoking writer methods so it doesnt make sense to not use `self`. The only other option would be to use `self` in another method then simply invoke the deledated method within the method but I dont know if this is skirting around the problem.
    # AH! ofcourse you reference the `@age` variable directly so obvious..

end

soup = Cat.new('Black Cat')
soup.make_one_year_older
soup.make_one_year_older
p soup


# This code  defines a `Cat` class with the attributes `type` and `age`. The behavior associated with the class is that of incrementing the `age` of a given `Cat` instance by 1, when the `make_one_year_older` instance method is invoked. According to the Ruby style guide the `self` keyword can be left out when it does not provide added clarity as to the intention of code or is not functionally required to execute a given line of code. In this example the expression `self.age += 1` is equivalent to `self.age = age + 1`. This effectively is `reassignment` so we would need to access the `age=` writer method for the method to execute because `self` is required when invoking `writer methods`. Therefore instead of the expression `self.age += 1` we can delegate this to an `increment` instance method which increments the value by a specified argument and invoke that method from within our `make_one_year_older` instance method

# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻

class Light
    attr_accessor :brightness, :color

    def initialize(brightness, color)
        @brightness = brightness
        @color = color
    end

    def self.information
        'I want to turn on the light with a brightness of level of super high and a color of green'
    end
end

# The return keyword is useless in this scenerio because `return` is typically used to return an explicit value and immediatly exit the method. In this case were using return on the last evaluated expression which is the default return value anyway.

# The attr_accessor mehtod would be required because they allow us to alter the values say turn on the light to a given brightness but now that I double check it is not INITIALLY required because the initial values would be explicitly assigned by us so there would be no need to alter the values unless we wish to change the default values which is not specified anywhere in the code.
