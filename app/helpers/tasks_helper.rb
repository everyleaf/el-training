module TasksHelper
  def print_month_day_wday(date)
    wday_int = date.wday
    wday_str = I18n.t('date.abbr_day_names')[wday_int]
    "#{date.month}/#{date.day}(#{wday_str})"
  end

  # 現在と同じソートソースが選ばれたらソート順を切り替え(昇順←→降順)
  # デフォルトは昇順
  def get_sort_direction(sort_source_of_redirect)
    # params[:sort]は現在のソートソース
    if (params[:sort] == sort_source_of_redirect) && (params[:direction] == 'ASC')
      'DESC'
    else
      'ASC'
    end
  end

  def sort_by(label, column)
    link_to label, tasks_path(sort: column, direction: get_sort_direction(column))
  end

  def sorted_by?(column)
    if @sort_by != column
      return
    end

    return_class = "sorting_params"
    return_class += " "
    return_class += @direction
    pp "******"
    pp return_class
    pp "******"
    return_class
  end
end
