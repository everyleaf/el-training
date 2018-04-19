class TodosController < ApplicationController
  def index
		@todos = Todo.all
  end
	
	def new
	end

	def create
		@todo = Todo.new
		@todo.title = params[:title]
		@todo.content = params[:content]
		@todo.save
		redirect_to('/todos/index')
	end
end
