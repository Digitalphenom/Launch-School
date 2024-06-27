# When a Constant is referenced, Ruby first searches in the current Class or Module where the Constant was referenced for a corresponding `Constant`. If not found it follows up with `enclosing scoped`, the `inheritance hierarchy` and finally the `top level scope`. If a `constant` is still not found a `NameError` is raised.

# In this scenerio, we have an `ElectronicStore` instance that collaborates with an `employee` instance to invoke the method `call_tech_lead` which references the `TECH_LEAD` constant. Although `ElectronicStore` and `Employee` collaborate, they are still seperate classes with no direct relationship. This means when we invoke `call_tech_lead` to reference the `TechTeam` constant, the search will end in a `nameerror`. To fix this we must explicitly tell ruby where to begin the search by specifying the location of the constant followed by the `namespace resolution operator` and the constant name.


module TechTeam
  TECH_LEAD = 'John'

  def install_drive
    'installing hard drive'
  end
end

class ElectronicStore
  include TechTeam

  def initialize
    @employee = Employee.new('joe')
  end
end

class Computer < ElectronicStore;end

class Speakers < ElectronicStore;end

class Employee
  attr_reader :employee

  def initialize(name)
    @name = name
  end
  def call_tech_lead
    puts "Call the tech lead: #{TECH_LEAD}" # leads to a nameerror 
    puts "Call the tech lead: #{TechTeam::TECH_LEAD}" # successfull execution 
  end
end

store = ElectronicStore.new

store.employee.call_tech_lead