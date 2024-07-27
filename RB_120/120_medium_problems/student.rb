class Student
  def initialize(name, year)
    @name = name
    @year = year
  end

  def school_name
      puts 'USC'
  end
end

class Graduate < Student
  def initialize(name, year, parking)
      super(name, year)
      @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
      super
  end
end

class Junior < Student

  def initialize(name, year)
      super
  end

  def school_name(name)
      super()
  end

end
# If we create another class that descends from `Student` and we use the `super` keyword within the `initialize` method without explicit arguments a argument error is raised because we must invoke the method in the superclass with the corresponding argument number. `super()` with parens invokes the method without explicit arguments. So the only scenerio where this would work would be if we define an instance method in the superclass that does not require arguments. Then we can invoke that method from within a `subclass` without explicit arguments
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

derek = Junior.new('Derek', 4)

p derek.school_name('UCLA') # USC