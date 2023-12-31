HSH = {}

class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end
end

class Owner
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def number_of_pets
    HSH[name].count
  end
end

class Shelter
  attr_reader :name, :type

  def adopt(owner, pet)
    HSH[owner.name] = [] if HSH[owner.name].nil?
    HSH[owner.name] << pet
  end

  def print_adoptions
    HSH.each do |owner, sub_arr|
      puts "#{owner} has adopted the following pets:"
      sub_arr.each do |pet|
      puts "a #{pet.type} named #{pet.name}"
      end
      puts
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."