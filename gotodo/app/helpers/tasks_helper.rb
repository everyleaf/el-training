# frozen_string_literal: true

module TasksHelper
  def sortable(column)
    column = column.to_s
    asc = link_to '▲', sort: column, direction: 'asc'
    desc = link_to '▼', sort: column, direction: 'desc'
    sortable = [Task.human_attribute_name(column)]
    if params[:sort] == column
      sortable << if params[:direction] == 'asc'
                    desc
                  else
                    asc
                  end
    else
      sortable.concat([asc, desc])
    end
    safe_join(sortable)
  end
end
