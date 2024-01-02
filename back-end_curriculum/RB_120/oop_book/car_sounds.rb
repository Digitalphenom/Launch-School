module Sound
  def output(sound)
    puts sound
  end
end

class Car
  include Sound
end

toyota = Car.new

p toyota.output("ruuum")

" We begin by defining a class named Car and then assign an instance of the Car class to the variable toyota which will reference the Car object."
