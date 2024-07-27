
class Machine
  def start
    puts 'Starting Machine..'
    self.flip_switch(:on)
  end
  
  def stop
    puts 'Stopping Machine..'
    self.flip_switch(:off)
  end

  def switch_state
    puts 'The switch is ' + switch.to_s.upcase
  end

  private
  
  attr_writer :switch
  attr_reader :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

machine = Machine.new

machine.start
machine.switch_state
machine.stop
machine.switch_state

machine.switch rescue ""

# When calling private methods, ruby used to require the use of a bareword identifier, however after 2.7 this requirement was relaxed allowing `self` or `bareword` for such calls.

# Modify this class so both flip_switch and the setter method switch= are private methods.