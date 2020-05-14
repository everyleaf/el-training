module TasksHelper
  def sortable(status, column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'desc' ? 'asc' : 'desc'
    link_to title, { status_id: status, sort: column, direction: direction }
  end
end
