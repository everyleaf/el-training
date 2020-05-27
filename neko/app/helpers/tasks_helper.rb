module TasksHelper
  def sortable(search, column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == 'desc') ? 'asc' : 'desc'
    link_to title, { name: search[:name], status: search[:status], sort: column, direction: direction }
  end
end
