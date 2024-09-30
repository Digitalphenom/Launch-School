=begin

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

create a clock class that instantiates clock objects. Each clock objects should have a `add` and subtract methods that adjust the time respectively.

  ▣ Explicit Req
    □ do not use built in functionality such as Date.new
    □ the state of each object should NOT be mutated
    □ When comparing the time for two seperate clock objects that have the same time should return true or should be equal
    □ generate time using arithmetic operations

  ▣ Implicit req
    □ create `at` class method that takes one or two arguments in integer form
    □ time format?
    □ What does time being independent of date mean
    □ first argument in `at` should represent an hour
      □ first argument input is valid from 0 upto 23
    □ second argument the minutes
      □ second arg in increment in minutes from 0 to 60
      □ if over reset 
        ﹥ 65 => 0:1
    □ What does `at` return?
      instance or time format?

    
#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Examples◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄


0 => 00:00
1 => 01:00
2 => 02:00
3 => 03:00
4 => 04:00
5 => 05:00
6 => 06:00
7 => 07:00
8 => 08:00
9 => 09:00
10 => 10:00 => 
11 => 11:00
12 => 12:00
13 => 13:00
22 => 22:00
23 => 23:00

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

intput: integer
hash => Lookup table
      Gen lookup

output: string with time format 00:00

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

  ▣ create a class method named at
    □ accept an hour and time value
    □ method should return a `clock` instance
  ▣ create a to_s method
    □ should return a time formated string
      ﹥ if hour is greater than 9 return hour otherwise add 0
      ﹥ if minutes is greater than 9 return minute otherwise add 0
    □ concatenate hour & minutes => 04:24
  ▣ a constructor method
    □ get total hour and time in minutes store in total iv
    □ retrieve total hours & minutes
  ▣ create a method that retrieves hour & minutes from total min time
    □ use modulo to (cycle around) minutes in a 24 hour day (1440)
      ﹥ 300 % 1440 => 300
      ﹥ 1440 % 1440 => 0
      ﹥ 1740 % 1440 => 300
    □ return the quotient and remainder from 60
  ▣ create a #- method
    □ method should retrieve current total and subtract time
    □ retrieve hour and minutes
    □ instantiate new clock object with new values
  ▣ A #+ method should repeat these steps but instead perform addition
  ▣ Create #== method that compares hour and minutes by value
=end

class Clock
  attr_reader :hour, :minutes

  def initialize(h, m)
    @total = (h * 60) + m
    @hour, @minutes = retrieve_hour_and_minutes(@total)
  end

  def self.at(hour = 0, minute = 0)
    Clock.new(hour, minute)
  end

  def to_s
    h = hour > 9 ? "#{hour}" : "0#{hour}"
    m = minutes > 9 ? "#{minutes}" : "0#{minutes}"
    "#{h}:#{m}"
  end

  def +(time)
    h, m = retrieve_hour_and_minutes(@total + time)
    Clock.new(h, m)
  end

  def -(time)
    h, m = retrieve_hour_and_minutes(@total - time)
    Clock.new(h, m)
  end

  def ==(other)
    hour == other.hour && minutes == other.minutes
  end

  private

  def retrieve_hour_and_minutes(total)
    (total % 1440).divmod(60)
  end

end



