module TasksHelper
  def print_month_day_wday(date)
    wday = Wday.new
    wday_int = date.wday
    "#{date.month}/#{date.day}(#{wday.get_wday_from_int(wday_int)})"
  end
end
