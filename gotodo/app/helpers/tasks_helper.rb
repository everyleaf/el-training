# frozen_string_literal: true

module TasksHelper
  def sortable(column)
    title = Task.human_attribute_name(column)
    if params[:sort] == column.to_s && params[:direction] == 'asc'
      direction = 'desc'
      title += ' ▲'
    elsif params[:sort] == column.to_s
      direction = 'asc'
      title += ' ▼'
    else
      direction = 'asc'
      title += ' ▲▼'
    end
    link_to title, sort: column, direction: direction
  end
end
