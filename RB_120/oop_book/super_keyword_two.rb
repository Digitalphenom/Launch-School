
class Animal
  def initialize
  end
end

class Dog < Animal
  def initialize(color)
    super
    @color = color
  end
end

class BadDog < Animal
  def initialize(color)
    super()
    @color = color
  end
end

bear = BadDog.new("blue")

p bear
