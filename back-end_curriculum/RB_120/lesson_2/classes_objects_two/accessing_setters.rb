class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(name)
    self.name = name
  end
end

kitty = Cat.new("Sophie")
kitty.name # Sophie
kitty.rename("Chloe") 
kitty.name # Chloe
