
class Student
  def initialize(name, year)
    @name = name
    @year = year
    @parking = validate_parking
  end
  
  def validate_parking; self.class == Graduate ? true : false; end

end

class Graduate < Student
end

class UnderGraduate < Student
end

p Graduate.new('Joe', 2028)
p UnderGraduate.new('D', 2023)

#-----------------------------------------
puts 

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year)
    super(name, year)
    @parking = true
  end
end

class Undergraduate < Student
end

class Junior < Student
end

p Graduate.new('Joe', 2028)
p UnderGraduate.new('D', 2023)
p Junior.new('Sed', 2030)

# If we define an additional class that inherits from `Student` and call `super()` without arguments. An argument error will be raised because `super` invokes a corresponding method in the `method lookup path` with the same amount of arguments. In this case, `initialize` in `Student` requires a `name` and `year` argument which would not be forwarded if we used `super()`.