# frozen_string_literal: true

module Admin::UsersHelper
  def sortable(column)
    column = column.to_s
    asc = link_to '▲', { sort: column, direction: 'asc' }, { id: "#{column}_asc" }
    desc = link_to '▼', { sort: column, direction: 'desc' }, { id: "#{column}_desc" }

    sortable = [User.human_attribute_name(column) + '　']
    if params[:sort] == column
      sortable.concat(params[:direction] == 'asc' ? [desc] : [asc])
    else
      sortable.concat([asc, desc])
    end
    safe_join(sortable)
  end
end
