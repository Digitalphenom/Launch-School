class Person
  attr_accessor :first_name, :last_name
  

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def to_s
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end

person = Person.new("john", "doe")
puts person # "John Doe"

person.first_name = "jane"
person.last_name = "smith"
puts person # jane smith

# this code begins by defining a Person class. Within the class a initialize method is defined and two parameters are set `first_name` & `last_name`. When an instance of `Person` is instantiated and passed a first and last name argument, both names are `capitalized` and assigned to their respective 'instance variables'. further in the class a `to_s` method is defined which `interpolates` the `@first_name` and `@last_name` instance variables and outputs the first_name and last_name when `puts` is called on an instance of `Person`.