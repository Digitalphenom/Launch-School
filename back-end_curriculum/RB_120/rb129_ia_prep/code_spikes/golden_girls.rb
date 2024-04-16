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
# - Dorothy has an ex-husband by the name of Stan Zbornak.

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

require 'pry'

class House
  def initialize
    @home_address = '6151 Richmond Street Miami, FL'.split
  end
  
  def home_address
    @home_address.join(' ')
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class Inhabitants
  attr_reader :nationality, :relationship_status, :work_status, :age, :first_name, :last_name
 
  def initialize(name)
    @first_name, @last_name = convert_to_upcase(name)
    @nationality, @relationship_status, @work_status, @age = assign_attributes(name)

    @unique_details = validate_detail(name)
  end

  def convert_to_upcase(name)
    name.split.map { |word| word.capitalize }
  end

  def validate_detail name
    name = name.split.first

    case name
      when 'dorothy' then 'she has an ex-husban named Stan Zbornak and stays home on saturday evenings'
      when'blanche' then 'she dates younger men'
      when 'rose' then 'has a long term boyfriend'
    end

  end

  def assign_attributes name
    case name
      when 'dorothy', 'blanche', 'rose' then ['American', 'widowed', 'employed', 'Over 50']
      else
      ['Italian', 'widowed', 'unemployed', 50]
    end
  end

  def unique_details
    @unique_details.capitalize if @unique_details
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class SearchDataBase
  attr_reader :user_profile, :user_location

  def initialize name
    @user_profile = Inhabitants.new(validate_name(name))
    @user_location = House.new
  end

  def validate_name(name)
    first_name = name.downcase.split.first
    return name if ['dorothy', 'blanche', 'rose', 'sofia'].include?(first_name)
    raise ArgumentError, 'You entered an unknow name please try again.'
  end

  def retrieve_user_name
    puts "First Name: #{user_profile.first_name}"
    puts "Last Name: #{user_profile.last_name}"
    puts
  end

  def retrieve_user_profile
    puts "First Name: #{user_profile.first_name}"
    puts "Last Name: #{user_profile.last_name}"
    puts "Nationality: #{user_profile.nationality}"
    puts "Age: #{user_profile.age}"
    puts "Relationship Status: #{user_profile.relationship_status}"
    puts "Work Status: #{user_profile.work_status}"
    puts "Address #{user_location.home_address}"
  end

  def retrieve_user_description
    puts '----------------------------'
    puts "#{user_profile.first_name} is a #{user_profile.relationship_status} #{user_profile.nationality} female\nover the age of #{user_profile.age} and #{user_profile.work_status}.\n#{user_profile.unique_details}"
    puts '----------------------------'
  end
end

search_dorothy = SearchDataBase.new('dorothy zbornak')
search_rose = SearchDataBase.new('rose nylund')
search_sofia = SearchDataBase.new('sofia petrillo')
search_blanche = SearchDataBase.new('blanche deveraux')

[search_dorothy, search_rose, search_sofia, search_blanche].each do |name|
  puts name.retrieve_user_profile
  puts name.retrieve_user_description
end
