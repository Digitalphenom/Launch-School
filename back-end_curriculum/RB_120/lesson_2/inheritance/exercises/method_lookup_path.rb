class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
puts Cat.ancestors

#Cat
#Animal
#Object
#Kernel
#BasicObject

