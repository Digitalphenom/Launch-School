class GoodDog
  attr_accessor :name, :gender, :weight

  def initialize(name, gender, weight)
    @name = name
    @gender = gender
    @weight = weight
  end

  def speak
    "#{name} says Boooorff!"
  end

  def change_info(n, g, w)
    self.name = n
    self.gender = g 
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is a #{self.gender}"
  end
end

pepper = GoodDog.new("Pepper", "Male", "25 lbs")
tina = GoodDog.new("Tina", "Female", "18 lbs")

p pepper.speak
p tina.name

p pepper.name
p pepper.info

tina.change_info("Cherry", "Female", "12 lbs")
puts
p tina.info