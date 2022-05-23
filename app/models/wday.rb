class Wday
  def initialize
    @wday_all = %W(\u65E5 \u6708 \u706B \u6C34 \u6728 \u91D1 \u571F) # ’日', '月',...,'土'
  end

  def get_wday_from_int(wday_int)
    @wday_all[wday_int]
  end
end
