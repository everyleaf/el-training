# frozen_string_literal: true

module TasksHelper
  def sortable(column)
    column = column.to_s
    column_name = Task.human_attribute_name(column)
    asc = link_to '▲', sort: column, direction: 'asc'
    desc = link_to '▼', sort: column, direction: 'desc'
    if params[:sort] == column
      if params[:direction] == 'asc'
        sortable = column_name + desc
      else
        sortable = column_name + asc
      end
    else
      sortable = column_name + asc + desc
    end
    sortable.html_safe
  end
end
