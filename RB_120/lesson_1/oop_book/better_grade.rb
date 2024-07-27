class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_grade)  
    grade < other_grade.grade
  end

  protected
  attr_reader :name, :grade  
end

james = Student.new("James", "A")
joe = Student.new("Joe", "C")

puts "Well done!" if james.better_grade_than?(joe)