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

  ▣ Create a class called Clock
  ▣ create a class method `at` 
    □ instantiates a clock object
    □ pass coresponding value
    □ returns a clock object

  ▣ convert input values to minutes since midnight
    □ multiply hour by minutes
    □ add minutes
    □ get quotiend & remainder
     23 + 30 + 60
     23 * 60 = 1380
     1380 + (30 + 60 ) = 1470
     [q24, r30]
  ▣ determine time loop
    □ if hour is greater than 23 return to 0

  ▣ define to_s method
    □ invoking to_s should return clock format
      □ if hour is greater than 9 return num as is otherwise insert 0
      □ if minute is greater than 9 repeat above otherwise repeat above
  ▣ create + method
    invoking - should subtract the specified time
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



