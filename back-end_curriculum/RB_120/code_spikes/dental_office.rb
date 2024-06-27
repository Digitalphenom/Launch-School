# There's a dental office called Dental People Inc. within which there are 2 oral surgeons, 2 orthodontists, 1 general dentist. Both general dentists and oral surgeons can pull teeth. 

#Orthodontists cannot pull teeth. Orthodontists straighten teeth. Oral surgeons place implants. General dentists fill teeth. 

# All of these aforementioned specialties are dentists. All dentists graduated from dental school.

=begin

▣ Peoples, Places, Things
  □ Dental Office
  □ Oral Surgeons
  □ Orthodontist
  □ General Dentist

▣ Actions
  ﹥ Fill Teeth
  ﹥ Pull Teeth
  ﹥ Straighten Teeth
  ﹥ Place Implants

▣ Attributes
  □ Specialty
  □ Graduate School

class Dental Office
  def intiialize
    @office_name =  Dental People Inc
    @specialties = Dentist.new
  end

  def to_s
    Welcome to :
    @office_name
    we specialize in
    @specialties.each do |instance|
      instance.class
    end
    'we do'
    @@specialties.each do |instance|
      instance.ability
    end
end

class Dentists < Dental Office
  def initialize
    @specialty = [OralSurgeron.new, GeneralDentist.new, Orthodontist.new]
  end
end

class OralSurgeon < Dentist
  def ability
    PULL TEETH
    PLACE IMPLANTS
  end
end

class GeneralDentist < Dentist
  def ability
    PULL TEETH
    Place TEETH
  end
end

class Orthodontist < Dentist
  def ability 
    STRAITEN TEETH
  end
end
=end

require 'pry'

module PullTeethAble
  def pull_teeth
    'Pulls Teeth'
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class DentalOffice
  attr_reader :dentists, :name

  def initialize
    @name = 'Dental People Inc'
    @dentists = Dentist.new
  end

  def to_s
    "Welcome To: #{name}!\nWe Specialize In:\n--------------\n#{display_specialties}\n--------------\nOur Services Are:\n--------------\n#{display_abilities}\n--------------\n"
  end

  def display_specialties
    dentists.specialties.map do |dentist|
      "#{dentist.specialization}: #{dentist.available.to_s} available"
    end.join("\n")
  end

  def display_abilities
    dentists.specialties.map do |dentist|
      "The #{dentist.class.to_s} : #{dentist.ability} "
    end.join("\n")
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Dentist
  attr_reader :specialties, :available, :school_credentials
  
  def initialize
    @specialties = [GeneralDentist.new, OrthoDontist.new, OralSurgeon.new]
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class GeneralDentist < Dentist
  include PullTeethAble
  
  def initialize
    @available = 2
    @school_credentials = true
  end
  def ability
    "Fills and #{pull_teeth}"
  end
  
  def specialization
    'General Dentistry'
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class OralSurgeon < Dentist
  include PullTeethAble
  
  def initialize
    @available = 2
    @school_credentials = true
  end
   
  def ability
    "#{pull_teeth} & Places Implants"
  end
  
  def specialization
    'Oral Surgery'
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class OrthoDontist < Dentist
  def initialize
    @available = 1
    @school_credentials = true
  end
  
  def ability
    'Straightens Teeth'
  end
  
  def specialization
    'Orthodontistry'
  end
end

#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class AccreditOffice
  attr_reader :eligibility, :dental_office
  attr_writer :eligibility
  
  def initialize(dental_office)
    @dental_office = dental_office
    @eligibility = check_eligibility?
  end
  
  def check_eligibility?
    dental_office.dentists.specialties.all? do |dentist|
      dentist.school_credentials
    end
  end
  
  def eligibility_input
    return self.eligibility = 'NOT' if eligibility
    self.eligibility = ''
  end
  
  def check_if_eligible
    puts "The Dentist Office:\n#{dental_office.name.upcase}\n Is #{eligibility} Accredited!" 
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

dental_people_inc = DentalOffice.new
puts dental_people_inc()
AccreditOffice.new(dental_people_inc).check_if_eligible