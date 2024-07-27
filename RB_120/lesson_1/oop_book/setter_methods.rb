class Project
  def initialize
    @name = "Q4 Tech updates"
    @budget = 10000
    @team_members = ["Sedrick", "Jacob", "Javier"]
  end

    def name
      @name
    end

    def budget
      @budget
    end

    def team_members
      @team_members
    end

    def budget=(b)
      @budget = b
    end

end

convention = Project.new
convention.name