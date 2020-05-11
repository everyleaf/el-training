module TasksHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'desc' ? 'asc' : 'desc'
    link_to title, { sort: column, direction: direction }
  end
end
