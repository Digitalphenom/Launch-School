=begin

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ 𝓟roblem ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

Create a clock that is independent of date

▣ Explicit Requirements
  □ Can add or subtract minutes from Clock object
  □ Should not mutate clock object when adding or subtracting
  □ when moding object values (add/sub time) return a new clock obj
  □ Two seperate objects with same time should be equal
  □ Dont use built in methods to generate time/arithmetic only

▣ Implicit Req
  □ A clock that is independent of date means?
    ﹥total time in a day should be tracked and displayed as time

  □ to_s converts object into corresponding time format
    ﹥ Clock.at(8) => '08:00'
  □ at class method
    ﹥ accepts 2 arguments
      ﹥(hour, minutes)
  □ + method
    ﹥ adds to time
  □ - method
    ﹥ removes from time
    ﹥ non mutating
  □ clock should cycle back and forth

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ TEst_cases ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

test_on_the_hour
assert_equal '08:00', Clock.at(8).to_s
assert_equal '09:00', Clock.at(9).to_s

test_past_the_hour
assert_equal '11:09', Clock.at(11, 9).to_s

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ DS ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

input: Time int

intermediary: total time
 minutes in day?
  ▣ track total time by minutes
    24 * 60 => 1440
    performs subtraction or addition
     1440 - 120min = 1320
  ▣ convert into equivalent time
    1320 / 60 => 22
  ▣ convert into format string

output: time string format "08:00"

#⋄≂≂▫≂≂▫≂≂▫≂▫≂▫≂≂▫≂≂▫≂⋄—◟ Algor ◞—⋄≂▫≂≂▫≂≂▫≂≂▫≂▫≂≂▫≂≂▫≂≂≂⋄

  ▣ Create clock class
  ▣ create at class method
    □ track total minutes
      ﹥since were returning instances instantiate a clock instanced and track through iv
  ▣ create to_s
    ﹥ should return a string rep of clock object
  ▣ + method 
    ﹥ should add to existing time
      □ input time always comes in as minutes
        ﹥ convert minutes into hour/minutes
        ﹥ create new time instance with inputs
        ﹥ return
    ﹥ return a new clock object

  ▣ - method
    ﹥ should subtract from existing time
    ﹥ return a new clock object
  ▣ Time should wrap around
    ﹥ if total time goes over 1440 minutes
      ﹥ reset to 0 => 1440
      ﹥ current_clock 23 => 1380 + 120 = 1500
        25 hours 24 + 60 minutes
      create a method names reset_time
        □ should reset time to 1440
          ﹥ if total time is greater than 1440
            ie 1440 + 60 = 1510
            get the difference 1510 - 1440 
            70.divmod(60) [1h, 10min]
            

=end

class Clock
  attr_reader :hour, :minute, :total

  def initialize(hour, minute)
    @hour = hour
    @minute = minute

    @total = (hour * 60) + minute
  end

  def self.at(hour, minute = 0)
    hour = 24 if hour.zero? 
    Clock.new(hour, minute)
  end

  def to_s
    format('%02d:%02d', hour, minute)
  end

  def -(time)
    new_time = total - time

    new_time = reset_time(new_time) if new_time < 0
    Clock.new(*new_time.divmod(60))
  end

  def +(time)
    new_time = total + time
    new_time = reset_time(new_time) if new_time > 1440
    Clock.new(*new_time.divmod(60))
  end

  def ==(other)
    hour == other.hour && minute == other.minute
  end

  def subtract_time(total_time)
    until total_time >= 0
      total_time = 1440 - total_time.abs
    end
    total_time
  end

  def reset_time(total_time)
    until total_time <= 1440
      total_time = total_time - 1440
    end
    total_time
  end
end

# - 2461
# 1440 - 2461 = 1021
# 1440 - 1021 = 419
# 419 / 60 = 6 = 6hours, 59minutes

#6hours, 59minutes = 419totalmin
#24 - 6
#1440 - 419


