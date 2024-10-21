
=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

write a program that generates a random robot name ie:
RX837
BC811

The robot should be resettable, meaning that when you invoke a certain method its name is reset to empty?.
The next time you ask (invoke a method) a new random name is generated.

▣ Explicit Requirements
  □ names must be random
  □ not follow predictable sequence
  □ [ ] keep track of all added names
    ﹥ ensure no dups

▣ Implicit Req
  □ name instance method
    ﹥ name generates new name
  □ constructor method
    ﹥ sets name to nil or gives default name?
  □ reset instance method
    ﹥ reset removes name sets to default name
  

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ TestCases ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

NAME_REGEXP, Robot.new.name
  □ This should generate a new name with the pattern
    (RX837)(BC811)

robot.name, robot.name
  □ names must match 

Kernel.srand DIFFERENT_ROBOT_NAME_SEED
refute_equal Robot.new.name, Robot.new.name
  □ Names should never be the same even accross instances

Kernel.srand DIFFERENT_ROBOT_NAME_SEED
robot = Robot.new
name = robot.name
robot.reset
name2 = robot.name
refute_equal name, name2
assert_match NAME_REGEXP, name2
  □ reset should remove from existing taken name?
  □ names should not collide
  □ all robot instances should follow the robot naming pattern

Kernel.srand SAME_INITIAL_ROBOT_NAME_SEED
name1 = Robot.new.name
Kernel.srand SAME_INITIAL_ROBOT_NAME_SEED
name2 = Robot.new.name
refute_equal name1, name2
  □ Two seperate robots cannot have the same name
  □ if name is taken generate a new name



#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
  input:
when should a new name be generated
  name or ?
  output:

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
  ▣ Create Robot Class
  ▣ Create constructor method
  ▣ create instance methods
    □ name
      ﹥ name should generate then retrieve name
    □ reset
    □ generate name 
      ﹥ define as private and invoke from name
      ﹥ generate a random letter sequence
          ﹥ create sequence from a -z
          ﹥ shuffle then get last 3
      ﹥ generate a random number sequence
      ﹥ concatenate
  ▣ create class variable
    □ should track all names
      ﹥ when name is generate
        ﹥ add to all_names
      ﹥ when name is reset/removed
        ﹥ remove from all_names

=end

class Robot
  @@all_names = []
  ALPHA = ("A".."Z").to_a

  attr_reader :name

  def initialize
    @name = generate_name
  end

  def reset
    @@all_names.delete(@name)
    @name = generate_name
  end

  private

  def generate_name
    @name = ""
    loop do
      2.times { @name += ALPHA.shuffle.last }
      3.times { @name += rand(0..9).to_s }
      next @name = "" if @@all_names.include?(name)
      break
    end
    @@all_names << @name
    @name
  end
end
