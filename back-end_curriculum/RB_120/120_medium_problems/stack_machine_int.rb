=begin
⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
 Write a OOP version of the minilang problem where we emulate a stack_like structure where a register captures values based on the command supplied.

 These are the following commands

  ▣ n Place a value n in the "register". Do not modify the stack.

  ▣ PUSH Push the register value on to the stack. Leave the value in the register.

  ▣ ADD Pops a value from the stack and adds it to the register value, storing the result in the register.

  ▣ SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.

  ▣ MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.

  ▣ DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.

  ▣ MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.

  ▣ POP Remove the topmost item from the stack and place in register

  ▣ PRINT Print the register value


=end

class Minilang
  COMMANDS = ['SUB', 'ADD', 'PUSH', 'MULT', 'DIV', 'POP', 'PRINT', 'MOD']

  def initialize(commands)
    @stack = []
    @register = 0
    @current_value = 0
    @commands = validate_commands(commands)
  end

  def validate_commands(commands)
    filtered_arr = commands.split.select { |ele| ele.match?(/[^-+0-9]/) }

    filtered_arr.each do |ele|
      raise ArgumentError, "Invalid TOKEN: #{ele}" unless COMMANDS.include?(ele)
    end
    commands.split
  end

  def eval
    @commands.each {|ele| ele.match?(/\d/) ? n(ele) : send(ele.downcase)}
  end

  def n(command)
    @register = command.to_i
  end

  def mult
    @register *= @stack.pop
  end

  def add
    @register += @stack.pop
  end

  def sub
    @register -= @stack.pop
  end

  def div
    @register /= @stack.pop
  end

  def mod
    @register = @register % @stack.pop
  end

  def pop
    @register = @stack.pop
  end

  def print
    puts @register
  end

  def push
    @stack << @register
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
begin
Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8
# 
Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5
# 
Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!
# 
Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6
# 
Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12
# 
Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB
rescue ArgumentError => e
  puts e.message
  # 
  Minilang.new('-3 PUSH 5 SUB PRINT').eval
  #  8

  Minilang.new('6 PUSH').eval
  # (nothing printed; no PRINT commands)
end
