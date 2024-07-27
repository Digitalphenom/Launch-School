
class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata

# this code begins by defining a class named Something, along with an intiialize method which assigns the default value of `Hello` to `@data` upon object instantiation. Furthermore, a 'dupdata' instance method is defined which concatenates `@data` with `@data` and a class method called `dupdata` is also defined which returns `ByeBye`.

# After line 16 instantiates an instance of `Something` and assigns it to the local variable `thing`, line 17 outputs a call to the class methods `self.dupdata` which returns the value `ByeBye` and line 18 calls `dupdata` on the class instance `thing` which outputs `HelloHello`.