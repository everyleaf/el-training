class Wday
  def initialize
    @wday_all = ['日', '月', '火', '水', '木', '金', '土']
  end

  def get_wday_from_int(wday_int)
    @wday_all[wday_int]
  end
end
