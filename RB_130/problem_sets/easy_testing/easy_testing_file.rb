
class NoExperienceError < StandardError

end

class Employee
  def initialize(name, experience)
    @name = name
    @experience = experience
  end

  def hire
    raise NoExperienceError if @experience < 2
    true
  end
end


class Documents
  attr_reader :list

  def initialize(name)
    @folder = []
    @folder << name
  end

  def process
    @folder.pop
  end
end

