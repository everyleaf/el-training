# frozen_string_literal: true

module TasksHelper
  def sortable(column)
    column = column.to_s
    hash = { title: params[:title], status: params[:status], sort: column }
    asc = link_to '▲', hash.merge({ direction: 'asc' }), id: "#{column}_asc"
    desc = link_to '▼', hash.merge({ direction: 'desc' }), id: "#{column}_desc"

    sortable = [Task.human_attribute_name(column) + '　']
    if params[:sort] == column
      sortable.concat(params[:direction] == 'asc' ? [desc] : [asc])
    else
      sortable.concat([asc, desc])
    end
    safe_join(sortable)
  end
end
