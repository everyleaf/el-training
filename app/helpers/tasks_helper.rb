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

  # 現在のfilterパラメータを残したままsortパラメータを更新
  def sort_link(sort_by, direction, label, column)
    if sort_by == column
      # 現在ソートされているcolumnのみ、並び順(ASC,DESC)をクラスとして付与
      sort_class = direction
    end

    # URL中のソートのクエリパラメータを更新
    uri = URI.parse(request.url)
    query = Rack::Utils.parse_nested_query(uri.query)
    query['sort']      = column
    query['direction'] = get_sort_direction(column)
    uri.query = query.to_param
    url = uri.to_s

    link_to label, url, class: sort_class
  end
end
