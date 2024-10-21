

class Clock
  # attr_reader :hour, :minute, :total
# 
  # def initialize(hour, minute)
  #   @hour = hour
  #   @minute = minute
# 
  #   @total = (hour * 60) + minute
  # end
# 
  # def self.at(hour, minute = 0)
  #   hour = 24 if hour.zero? 
  #   Clock.new(hour, minute)
  # end
# 
  # def to_s
  #   format('%02d:%02d', hour, minute)
  # end

  # def ==(other)
  #   hour == other.hour && minute == other.minute
  # end

  def -(time)
    new_time = total - time

    #new_time = reset_time(new_time) if new_time < 0
    new_time = reset_time(new_time) {|new_total| new_total < 0 }
    Clock.new(*new_time.divmod(60))
  end

  def +(time)
    new_time = total + time
    new_time = reset_time(new_time) {|new_total| new_total <= 1440 }

    #new_time = reset_time(new_time) if new_time > 1440
    Clock.new(*new_time.divmod(60))
  end

  def reset_time(total_minutes)
    boolean = false

    loop do
      if total_minutes < 0
        total_minutes = 1440 - total_minutes.abs
        break total_minutes if yield(total_minutes)
      else
        total_minutes = total_minutes - 1440
      break total_minutes if yield(total_minutes)
      end
    end
  end
end

