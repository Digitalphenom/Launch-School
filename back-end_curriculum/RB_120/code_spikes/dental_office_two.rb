
module PullTeethAble
    def pull_teeth
      'Pulls Teeth'
    end
  end
  
  #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  
  class DentalOffice
    attr_reader :dentists, :name, :general_dentists, :oral_surgeons, :orthodontists
  
    def initialize(dentists)
      @name = 'Dental People Inc'
      @general_dentists, @oral_surgeons, @orthodontists = dentists
    end
  
    def to_s
      puts "Welcome To: #{name}!"
      puts 'The following Dentists are available:'
      puts '--------------'
      puts "#{print_dentist_data}"
    end
  
    def print_dentist_data
      [general_dentists, oral_surgeons, orthodontists].each do |group|
        group.each do |dentist|
          puts
          puts "Name: #{dentist.name}"
          puts "Specialization: #{dentist.specialization}"
          puts "School: #{dentist.school_credentials}"
          puts "Years Experience #{dentist.experience}"
          puts
          puts "------------------------"
        end
      end
      nil
    end
  end
  
  #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  
  class Dentists
    attr_reader :name, :specialization, :available, :school_credentials, :experience
    def initialize(name, school, experience)
      @name = name
      @school_credentials = school
      @experience = experience
    end
  end
  
  #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  
  class GeneralDentist < Dentists
    include PullTeethAble
  
    def initialize(name, school, experience)
      super
      @specialization = 'General Dentistry'
    end
  
    def ability
      "Fills and #{pull_teeth}"
    end
  end
  
  #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  
  class OralSurgeon < Dentists
    include PullTeethAble
  
    def initialize(name, school, experience)
      super
      @specialization = 'Oral Surgery'
    end
  
    def ability
      "#{pull_teeth} & Places Implants"
    end  
  end
  
  #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  
  class OrthoDontist < Dentists
    def initialize(name, school, experience)
      super
      @specialization = 'Orthodontistry'
    end
  
    def ability
      'Straightens Teeth'
    end
  end
  
  #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
  general_dentist = [GeneralDentist.new('Chris','Harvard', 14), GeneralDentist.new('Diana', 'Community College', 3)]

  oral_surgeons = [OralSurgeon.new('Clare', 'USC', 4),OralSurgeon.new('Beavis', 'USC', 7),]

  orthodontist = [ OrthoDontist.new('Joon', 'Ucla', 2) ]
  
  professionals = [general_dentist, oral_surgeons, orthodontist]
  
  dental_people_inc = DentalOffice.new(professionals)
  puts dental_people_inc