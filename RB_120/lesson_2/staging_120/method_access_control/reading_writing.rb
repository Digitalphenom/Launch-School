class Person
  attr_accessor :name
  attr_reader :phone_number
end

person1 = Person.new
person1.name = "Jessica"
puts person1.name
