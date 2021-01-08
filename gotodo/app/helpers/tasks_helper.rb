# frozen_string_literal: true

module TasksHelper
  def sortable(column)
    column = column.to_s
    sortable = [Task.human_attribute_name(column)]
    asc = link_to '▲', { title: params[:title], status: params[:status], sort: column, direction: 'asc' }, id: "#{column}_asc"
    desc = link_to '▼', { title: params[:title], status: params[:status], sort: column, direction: 'desc' }, id: "#{column}_desc"

    if params[:sort] == column
      sortable.concat(params[:direction] == 'asc' ? [desc] : [asc])
    else
      sortable.concat([asc, desc])
    end
    safe_join(sortable)
  end
end
