
=begin
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
   Given an input of a day of week and :
    first, second , third, fourth, fifth and teenth
  return the corresponding day in a meetup date object ie (date object)

  ▣ explicit
    □ the string inputs should correspond with a week number
    □ the Day should retrieve a corresponding day from that week
    □ teenth retrives 13, 14, 15, 16, 17, 18, 19
    □ last retrieves the last input day of week
    □ input week and day name case insensitive
    
  ▣ implicit
    □ return a date object
    □ redefine how comparison is conducted on instances
      compare day numbers


#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄


#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
    input: integer dates
      collect each date instances in groups of 5 weeks
      increment one day per instance upto the end of month
      array of weeks and instances
      [[obj],[obj]]
    output: date instances

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algorithm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
    ▣ Create a Meetup class
    ▣ define a `day` class method
      □ class method accepts two arguments
        □ year and month
      □ instantiate a Date instance
    ▣ Generates weeks
      □ create two arrays
      insert one array upto 7 instances
      reset and repeat
      each inserted instance should get next day
      continue upto end of month

    ▣ retrieve week
      □ Case statement
        when first 0
        when second 0
        when last -1
    ▣ retrieve teenth
      access the 11-19 day
        □ 
      place in new array
      return array
=end

require 'date'

class Meetup
  attr_reader :date, :total

  def initialize(year, month)
    @date = Date.new(year, month)
    @total = []
  end

  def day(day, week)
    generate_days
    #require 'pry'; binding.pry
    retrieve_week_and_day(day, week)
  end
  
  private
  
  def retrieve_week_and_day(day, str)
    idx = case str.downcase
    when "first" then 0
    when "second" then 1
    when "third" then 2
    when "fourth" then 3
    when "fifth" then 4
    when "last" then -1
    when "teenth" then return retrieve_instance(day,find_teenth)
    end
    @foo = total[idx]
    retrieve_instance(day, idx)
  end
  
  def find_teenth
    filtered_total = total[1] + total[2]
    valid_days = %w(13, 14, 15, 16, 17, 18, 19).map(&:to_i)
    
    x = filtered_total.map.with_index do |date, idx|
      idx if valid_days.include?(date.day) 
    end
    require 'pry'; binding.pry
    total[x]
  end
  
  def retrieve_instance(day, idx)
    date = nil
    until date
      date = total[idx].select do |date|
        date.strftime("%A").downcase == day.downcase
      end.first
      idx -= 1
    end
    date
  end

  def generate_days
    temp_date = date.dup
    next_month = temp_date.next_month.month
    arr = []
    
    loop do
      arr << temp_date
      if arr.size == 7
        total << arr
        arr = []
      end
      temp_date = temp_date.next
      break total << arr if temp_date.month == next_month
    end
    total.reject!(&:empty?)
  end

  def ==(other)
    day == other.day
  end
end

meetup = Meetup.new(2016, 4)
meetup.day("tuesday", "last")

#month = Meetup.new(2017, 1)
#puts month.day("thursday", "teenth")

#"#{date.strftime("%B")}, #{date.day} #{date.strftime("%Y")} #{date.strftime("%A") }"