
class Meetup
  SCHEDULE_START_DAY = {
    'first' => 1,
    'second' => 8,
    'third' => 15,
    'fourth' => 22,
    'fifth' => 29,
    'teenth' => 13,
    'last' => nil
  }.freeze

  def initialize(year, month)
    @year = year
    @month = month
    @days_in_month = Date.civil(@year, @month, -1).day
  end

  def day(weekday, schedule)
    weekday = weekday.downcase
    schedule = schedule.downcase

    first_possible_day = first_day_to_search(schedule)
    last_possible_day = [first_possible_day + 6, @days_in_month].min
    require 'pry'; binding.pry

    (first_possible_day..last_possible_day).find do |day|
      date = Date.civil(@year, @month, day)
      break date if day_of_week_is?(date, weekday)
    end
  end

  private

  def first_day_to_search(schedule)
    SCHEDULE_START_DAY[schedule] || (@days_in_month - 6)
  end

  def day_of_week_is?(date, weekday) 
    case weekday
    when 'monday'    then date.monday?
    when 'tuesday'   then date.tuesday?
    when 'wednesday' then date.wednesday?
    when 'thursday'  then date.thursday?
    when 'friday'    then date.friday?
    when 'saturday'  then date.saturday?
    when 'sunday'    then date.sunday?
    end
  end
end


