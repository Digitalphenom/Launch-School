class Triangle
  def initialize(*sides)
    @sides = sides

    raise ArgumentError if unequal?
  end

  def kind
    @sides.each do |side|
      @val = case count_sides(side)
      when 3 then return 'equilateral'
      when 2 then return 'isosceles'
      else
        'scalene'
      end
    end
    @val
  end

  private 

  def count_sides(side)
    @sides.map(&:to_s).count(side.to_s)
  end

  def second
    1
  end

  def unequal?
    !(@sides.first + @sides[second] > @sides.last &&
    @sides.last + @sides[second] > @sides.first &&
    @sides.first + @sides.last > @sides[second])
  end
end
