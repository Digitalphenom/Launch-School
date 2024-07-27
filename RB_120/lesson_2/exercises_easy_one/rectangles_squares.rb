=begin
Add a square class
Have it inherit from Rectangle
When you create a new instance of Square with and pass it a single argument 

define an initialize method with 1 parameter, call the area method on the instance so that it calculates the result.

=end
class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  def initialize(area)
    super(area, area)
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"