
require 'date'
class Meetup
  attr_reader :year, :month

  WEEK = {
    'first' => 1,
    'second' => 2,
    'third' => 3,
    'fourth' => 4,
    'fifth' => 5
  }

  def initialize(year, month)
    @year = year
    @month = month
  end

  def day(week_day, d_number)
    week_day = week_day.downcase
    d_number = d_number.downcase
    date = Date.civil(year, month)

    day = if d_number == 'last'
            find_last_day(week_day, date)
          elsif d_number == 'teenth'
            find_teenth_day(week_day)
          else
            find_day(week_day, d_number, date)
          end

    return nil if day.nil?
    Date.civil(year, month, day)
  end

  def find_day(day, desired_week, date)
    current_day = 0
    current_week = 1

    until found_day?(day, date) && current_week == WEEK[desired_week]
      date = date.next
      current_day += 1
      current_week += 1 if current_day % 7 == 0
      return nil if month != date.month
    end
    date.day
  end

  def find_last_day(day, date)
    from_next_month = date.next_month
    count = 0

    until count == 7
      from_next_month = from_next_month.prev_day
      count += 1
      break if found_day?(day, from_next_month)
    end
    from_next_month.day
  end

  def find_teenth_day(day_name)
    date = Date.civil(year, month, 13)

    until date.day == 19
      date = date.next
      break if found_day?(day_name, date)
    end
    date.day
  end

  def found_day?(day_name, date)
    case day_name
    when 'monday' then date.monday?
    when 'tuesday' then date.tuesday?
    when 'wednesday' then date.wednesday?
    when 'thursday' then date.thursday?
    when 'friday' then date.friday?
    when 'saturday' then date.saturday?
    when 'sunday' then date.sunday?
    end
  end
end


=begin

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
create a program that generates a time object. each time object takes the numbers (1-12) representing months and a year (2021) then generates the correct corresponding date. The inputs will come in: first, second, third, fourth, fifth, last and teenth
along with the day of week:
(monday, first)
the output should be:
2nd wednesday of may 2024.

▣ Explicit Requirements
  □ time object requires 2 int arguments 
    ﹥ year
    ﹥ month
  □ return a time object
  
  □ day instance method
    ﹥ requires 2 string arguments
      - Day of week
      - [first, second, third, fourth, fifth, last and teenth]
    ﹥ returns date in string format 
      - (compared with Date.civil())
  □ teenth
    ﹥ a teenth inputs should extract all possible teenth days
      - 13th, 14th, 15th, 16th, 17th, 18th, 19th
    ﹥ the corresponding day of week should then be extracted if avail

▣ Implicit Requirements
  □ day should return a Date object to be compared with Date.civil()
    ﹥ Date.civil returns an object so your essentially comparing instances of object 
  □ your inputs will search for a corresponding day of week from the specified month and year.
  □ if no days are found nil is returned

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

test_teenth_monday_of_october_2016
meetup = Meetup.new(2016, 10)
assert_equal Date.civil(2016, 10, 17), meetup.day('Monday'teenth')

2016-10
search all days for input(Monday, 'teenth')
return corresponding day in date object format
nil otherwise

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄
input: Date int

intermediary:
  generate all days?
  search for corresponding input day
  input values into date object or return nil

output: Date object

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algortihm ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

▣ Create a Meetup class
▣ Create constructor requires 2 int arguments 
    ▣ year
    ▣ month
▣ day instance method
  □ requires 2 string arguments
    ﹥Day of week
      - [first, second, third, fourth, fifth, last and teenth]
    ﹥ returns date in string format 
      - (compared with Date.civil())

▣ generate days
  □ start with known inputs
    ﹥ year + month
    ﹥ begin day count with 1
      -convert 1 into its day_name equivalent
      - compare the day witha all possible days of week
      - if true compare first with amount of passes
    ﹥ determine end of month day


    ﹥ associate count with first sec..
        create hash with corresponding number of weeks

      - first = 1, second = 2, third = 3, fourth = 4 fifth = 5
      - initialize a count to 1
      - for every 7 days increment 1
      - 

    ﹥ get proper day
      - input required day
      - check if current obj is equal to day_name


      associate first second.. with a count
      until monday first
    ▣ if input is last
        □ retrieve the last 7 days beginning from first of next month
          ﹥ get next month
          ﹥ decrement 7 days
          ﹥ for each day check found_day?
  
=end

