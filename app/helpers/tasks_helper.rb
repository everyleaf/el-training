module TasksHelper

  def print_month_day_wday(date)
    wday_int = date.wday
    wday_str = I18n.t('date.abbr_day_names')[wday_int]
    "#{date.month}/#{date.day}(#{wday_str})"
  end
  