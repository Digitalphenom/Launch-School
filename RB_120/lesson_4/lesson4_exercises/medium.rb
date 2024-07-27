class BankAccount
    attr_reader :balance

    def initialize(starting_balance)
        @balance = starting_balance
    end

    def positive_balance?
        balance >= 0
    end
end

# There both right because the code would work either way. `@balance` would directly access the starting balance through the instance variable while `balance` would indirectly access the value assigned to `@balance` through the `getter` method. In this scenerio it doesnt make much difference because `@balance` is not dependent on additional processing from another method and the expression `balance >= 0` merely compares values.

# According to LS though Ben is right because a `reader` method was created so what would it's purpose be if not to use it?

# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻


# Question 2

class InvoiceEntry
    attr_reader :quantity, :product_name
    attr_writer :quantity
    
    def initialize(product_name, number_purchased)
        @quantity = number_purchased
        @product_name = product_name
    end

    def update_quantity(updated_count)
        self.quantity = updated_count if updated_count >= 0
    end

    private :quantity=

end

invoice = InvoiceEntry.new('Apple', 25)
invoice.update_quantity(35)
p invoice
#invoice.quantity=(-25)
p invoice

# This code will not perform the action we expect because if the intention is to update the `@quantity` value. The code as it is now will instead initialize a local variable to reference the updated value. To get the result were after, we would first need to create a `@quantity` setter method and then prepend the `self` keyword to the method name. This tells ruby that we are invoking a `writer` method on line 31. Another option would be to reference the `@quantity` instance variable directly like so `@quantity = updated count if updated_count >= 0`.

#followup 

# If we were to only change the `attr_reader` to `attr_accessor` and update the rest of the code accordingly `self.quantity = etc..`. It would technically work, however we would create a `writer` method for `product_name` and `quantity` as well. This could potentially pose a problem throughout the lifecycle of the class because the more public methods a class has avaialble the more likely an unintended change can occur to the state of an object. In this example Creating `attr_accessor` methods for both the `quantity` and `product_name` instance variables would make `writer` methods available outside the class where it has the potential for they to be misused. For this reason updating `attr_reader` to `attr_accessor` would not be the best choice.

# Solution
# For this reason I selectively created a `writer` method for `quantity` and not `product_name`. The `quantity=` writer can then be set to `private` to prevent it from being accessed outside the class.

# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻

class Greeting
    def greet(msg)
        puts "#{msg}"
    end
end

class Hello < Greeting
    def hi
        greet('Hello!')
    end
end

class Goodbye < Greeting
    def bye
        greet("GoodBye")
    end
end

msg = Greeting.new
msg.greet('hi joe')

Hello.new.hi
Goodbye.new.bye

# This code utilizes `inheritance` to reuse code defined in the `Greeting` superclass so that we dont have to write duplicate code from the `Hello` and `Goodbye` subclass.

# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻

class KrispyKreme
    def initialize(filling_type, glazing)
        @filling_type = filling_type 
        @glazing = glazing
    end

    def to_s
        return "#{add_filling} with #{@glazing}" if @glazing
        "#{add_filling} #{@glazing}"
    end

    def add_filling
        return 'Plain' if @filling_type.nil?
        @filling_type
    end

end

donut1 = KrispyKreme.new(nil, nil)
puts donut1 # KrispyKreme<j463546>
donut2 = KrispyKreme.new('Vanilla', nil)
puts donut2 # Vanilla
donut3 = KrispyKreme.new(nil, 'Sugar')
puts donut3 # Plain with Sugar
donut4 = KrispyKreme.new(nil, 'Chococolate Sprinkles')
puts donut4 # Plain with Sugar
donut5 = KrispyKreme.new('Custord', 'icing')
puts donut5 # Plain with Sugar


# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻

class Computer
    attr_accessor :template

    def create_template
        @template = 'template 14565'
    end

    def show_template
        self.template
    end
end

# - - - - -- - - -- - - - - -- - 

cpu =  Computer.new
cpu.create_template
p cpu.show_template

# - - - - -- - - -- - - - - -- - 


# ◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◅◸◤◟◞◥◹▻◥◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻◤◹▻


class Light
    attr_accessor :brightness, :color

    def initialize(brightness, color)
        @brightness = brightness
        @color = color
    end

    def status
        "I have a birghtness level of #{brightness} and a color of #{color}"
    end
end

# refactor this code so that the method name is more clear and less repetitive
# We can refactor the name of the method by ensuring that it does NOT include the class name. This helps when invoking the method on the class to have less repetive names.

light = Light.new
light.light_status