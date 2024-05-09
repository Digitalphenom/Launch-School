class Machine
    
    def start
        flip_switch(:on)
    end
    
    def stop
        flip_switch(:off)
    end

    def current_state
        puts switch
    end
    
    private
    attr_writer :switch
    attr_reader :switch

    def flip_switch(desired_state)
        self.switch = desired_state
    end
end

foo = Machine.new

foo.start
foo.current_state
foo.stop
foo.current_state

# The solution to this problem is straightforward. We wish to privatize the `flip_switch` instance method and the `switch=` writer method so we place the `access modifier` private above those methods. Before Ruby 2.7 Ruby enforced the use of a `bareword` when calling private methods, however after 2.7 this enforcement is no longer in place allowing `self` or a `bare` method call for such calls. We can leave the code as is or remove the `self` keyword either way both will correctly execute the call to `flip_switch`.