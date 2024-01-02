class Person
  attr_accessor :first_name, :last_name

  def initialize(first_name)
  @first_name = first_name
  @last_name = ""
  @name = first_name
  end

  def name
    return @name if @last_name == ""
    @name + " " + @last_name
  end

end


bob = Person.new("Robert")
p bob.name # bob
p bob.first_name
p bob.last_name
bob.last_name = "Smith"
p bob.name

# 3

class Person
  attr_accessor :last_name, :first_name


  def initialize(first_name, last_name="")
    @first_name = first_name
    @last_name = last_name
    @name = first_name + " " + last_name
  end

  def name
    @name.split.size > 1 ? @name : @name.strip
  end

  def name=(full_name)
    @name = full_name
    @first_name, @last_name = @name.split
  end

end

bob = Person.new("Rob")
bob.name
bob.first_name
bob.last_name
bob.last_name = "Smith"
bob.name

bob.name = "John Adams"
p bob.first_name
p bob.last_name


