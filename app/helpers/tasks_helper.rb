module TasksHelper
  def print_month_day_wday(date)
    "#{date.month}/#{date.day}(#{@wday.get_wday_from_int(date.wday)})"
  end
end
