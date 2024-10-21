
# Robot class
# Robot #name instance method
# reset instance method
=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
Generate a random name in the format of two upper case characters followed three digits ie
  RB458
  RS858
  ZF812
Have the option to reset name to blank. 

  Explicit Requirements
    □ generate name sequence in 
    □ include reset option that wipes name clean
    □ have initiate option that generates ran name
    □ ran names should never collide ie names should be unique
      □ not follow predictable sequence

  ▣ Implicit requirements
    □ Name gets wiped what is it set to?
      □ empty string?
    □ Do not use rand to generate sequence of digits
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  class Robot
  name instance method generate sequence
  use array to populate sub-arrays of each digits type
  [A-Z].shuffle [0-9].shuffle grab first of each
    [A,"B",1,7,3] =>"A,"B",1,7,3"
    2 alpha chars strings
    3 digits digits
    Return String

    Reset would symbolize 00000

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algo ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

    ▣ Create a clas named Robot along with 2 instance methods
      □ name
      □ reset
      □ constructor
    ▣ Attributes
      □ name - factory setting value
    ▣ Class level data  
      □ clas VAR array used to gen ran alpha & digits

    ▣ instantiating a new instance should generate a new robot name 
      □ generate robot name
        □ shuffle alpha char and digit arrays
        □ retrives the last value
          [A b ] repeat two times
          [1 7 5] repeat three times
          "" << b, s
          "bs" << 1 7 3
    ▣ store name into a array of all generated names
      □ name is inserted or approved if it is not included in the generated names array

    ▣ reset instance method
      □ reset name to 00000

    ▣ return string

    # The names should not occur twice accross instances. Meaning that two different robots should not have the same name. To do this maintain a list of names on the level of the class and check it against every instance
        
=end

class Robot
  @@existing_names = []
  FACTORY = ""

  attr_reader :name

  def initialize
    @name = FACTORY
    generate_name
  end

  def reset
    @@existing_names.delete(self)
    self.name = FACTORY
  end

  def name
    generate_name if @name == FACTORY
    @name
  end

  private

  attr_writer :name

  def generate_name
    loop do
      2.times { @name += ('A'..'Z').to_a.shuffle.last }
      3.times { @name += (0..9).to_a.shuffle.last.to_s }

      @@existing_names << self

      break unless validate_name
      @name = FACTORY
    end
  end

  def validate_name
    @@existing_names.any? do |robot|
      robot != self && robot.name == name
    end
  end
end
