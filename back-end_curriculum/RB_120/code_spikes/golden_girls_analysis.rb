=begin
## GOLDEN GIRLS SPIKE
# The girls live in a house with an address of 6151 Richmond Street Miami, FL. There are four inhabitants of the house:
# - Dorothy Zbornak
# - Blanche Deveraux
# - Rose Nylund
# - Sofia Petrillo
# All of the girls are American, except for Sofia-- she's Italian. All the girls work, except for Sofia. All of them are widows, except for Dorothy.
# - Only Dorothy (stays home on Saturday evenings.)
# - Only Rose has a (long-term boyfriend.)
# - Only Blanche (dates younger men.)
# - All of the girls are over 50.
# - Dorothy has an ex-husband by the name of .

# Whos responsible for setting the initial state of attributes?

▣ Objects
  □ House
  □ Inhabitants
    - Dorothy Zbornak
    - Blanche Deveraux
    - Rose Nylund
    - Sofia Petrillo

▣ Attributes
  □ Address
    ﹥ Street Number
    ﹥ City
    ﹥ State

  □ Nationality
    ﹥ American
    ﹥ Italian
  □  Relationship Status
    ﹥ long-term boyfriend.
    ﹥ dates younger men
    ﹥ ex-husband by the name of Stan Zbornak.

  □ Work status
    ﹥ stays home on Saturday evenings.

  □ Age
    ﹥ over 50

class House
  def initialize(list)
    @address = [address, city, state]
  end

  def display_address(name)
    'Name address is @address ''
  end

end

class Inhabitatns

  def initialize(name, list)
    @name = name
    @nationality, @Relationship_status, @Work_status, @age = list
  end

end

class DataBase

  def initialize(name)
    @profile = Inhabitants.new(name, assign_attributes(name))
    @home = home.new
  end

  def search_attributes(object)
    object.name
  end

    def display_profile(name)
    "{name} is #{age}, {nationality} and {relationship status}. She {work}"
  end

  def display_attritute(object)
    name is #{object.attribute}
  end

  def assign_attributes(name)
    case name
    when 'silvia' then [american, maried, works, over 50]

  end

end

silvia = DataBase.new('silvia')

'puts object' outputs a profile of a given Golden Girl
A single method should be able to output a given Golden Girls
  □ nationality, relationship satus, work status, age and address.
=end

# The girls live in a house with an address of 6151 Richmond Street Miami, FL. There are four inhabitants of the house:
# - Dorothy Zbornak
# - Blanche Deveraux
# - Rose Nylund
# - Sofia Petrillo
# All of the girls are American, except for Sofia-- she's Italian. All the girls work, except for Sofia. All of them are widows, except for Dorothy.
# - Only Dorothy (stays home on Saturday evenings.)
# - Only Rose has a (long-term boyfriend.)
# - Only Blanche (dates younger men.)
# - All of the girls are over 50.
# - Dorothy has an ex-husband by the name of .

# Whats the case for using a module over inheritance in this scenerio?
# well interface inheritance is used over class inheritance when a class needs a behavior that it cant or wouldnt make sense to inherit from its superclass. For example in a Animal superclass and a dog, cat and rat subclass where certain subclasses require the ability to swim. It wouldnt make sense to define the behavior in the superclass because not ALL animals can swim. We can manually define it in each subclass but that would be breaking the DRY principle. In this case we would use Interface inheritance to define the behavior in a Swimmable module and include it into the classes that require it.

# So thats the general idea, however this scenerio is a bit different. We have a GilmoreGirls superclass and the individual 4 girls as subclasses where ALL of them are American and Windowed Except one person in the group which is Italian and has an ex-husband.

# in this scenerio it would make sense to define the common behavior in the Superclass and then override the behavior where its not needed in each subclass. The difference from the Animal example is that the non-required classes dont define any behavior relating to period. Whereas in this scenerio the `Married` and `Nationality` attributes is still avaialble. It would make no difference to define a module for both attributes and include it into the classes that require it because we would still need to manually define the required value for the non-commmon class group regardless if we rely on inheritance or interface inheritance. 

# The purpose of interface inheritance is to package together classes, methods or variables to share accross classes, organize code into named spaces and reduce duplicate code.

# What about distinguishing between behavior and characteristics as it relates to choosing II over I?

# This case doesnt necesarily have behavior that is common but characteristics whereas in your swim example the commonality is behavior based. Thats a crucial distinction to make because

# inhabitants
# GilmoreGirls

require 'pry'
class Inhabitants
    attr_reader :nationality, :relationship_status, :work_status, :age, :first, :last, :address, :unique_detail
  
    def initialize(name)
      @first, @last = convert_to_upcase(name)
      @age = 'Over 50'
      @address = '6151 Richmond Street Miami, FL'.split.join(' ')
      binding.pry
    end
    
    def convert_to_upcase(name)
      name.split.map { |word| word.capitalize }
    end
  
    private
    attr_writer :nationality, :work_status
  end

# ‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  class GilmoreGirls < Inhabitants
    def initialize(name, nationality, relationship_status, work_status, detail)
      super(name)
      @nationality = nationality
      @relationship_status = relationship_status
      @work_status = work_status
      @unique_detail = detail
    end
  
  end

  
  #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  
  class SearchDataBase
    attr_reader :user_profile, :user_location
  
    def initialize name
      @user_profile = validate_name(name)
    end
  
    def validate_name(name)
      first_name = name.first
      return name if ['dorothy', 'blanche', 'rose', 'sofia'].include?(first_name.downcase)
      raise ArgumentError, 'You entered an unknow name please try again.'
    end
  
    def retrieve_user_name
      puts "First Name: #{user_profile.first}"
      puts "Last Name: #{user_profile.last}"
      puts
    end
  
    def retrieve_user_profile
      puts "First Name: #{user_profile.first}"
      puts "Last Name: #{user_profile.last}"
      puts "Nationality: #{user_profile.nationality}"
      puts "Age: #{user_profile.age}"
      puts "Relationship Status: #{user_profile.relationship_status}"
      puts "Work Status: #{user_profile.work_status}"
      puts "Address #{user_profile.address}"
    end
  
    def retrieve_user_description
      puts '----------------------------'
      puts "#{user_profile.first} is a #{user_profile.relationship_status} #{user_profile.nationality} female\nover the age of #{user_profile.age} and #{user_profile.work_status}.\n#{user_profile.unique_detail}"
      puts '----------------------------'
    end
  end
  
  #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  dorothy = GilmoreGirls.new('dorothy zbornak','American', 'widowed', 'working', 'stays home on Saturday evenings.')
  rose = GilmoreGirls.new('rose nylund', 'American', 'widowed', 'working', 'eats chocolate')
  #sofia = GilmoreGirls.new('sofia petrillo')
  #blanche = GilmoreGirls.new('dorothy blanche deveraux')
  
  [dorothy, rose].each do |name|
    search_by_name = SearchDataBase.new(name)
    puts search_by_name.retrieve_user_profile
    puts search_by_name.retrieve_user_description
  end
  