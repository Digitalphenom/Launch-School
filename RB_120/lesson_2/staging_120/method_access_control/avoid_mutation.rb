
# given the following code, modify it so that we cannot mutate the state of the calling object. line 13 should return a new object and leave the calling objects state intact.

# class String
#   def reverse!
#     self.reverse
#   end
# end


class Person
  def initialize(name)
    @name = name
  end

  def name 
    @name.dup
  end
end

person1 = Person.new("James")
puts person1.name.reverse!
puts person1.name