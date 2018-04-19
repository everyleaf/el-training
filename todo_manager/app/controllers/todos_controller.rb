class TodosController < ApplicationController
  def index
		@todos = Todo.all
  end
	
	def new
		@todo = Todo.new
	end

	def create
		@todo = Todo.new
		@todo.title = params[:title]
		@todo.content = params[:content]
		if @todo.save
			flash[:notice] = "New todo has been created."
			redirect_to('/todos/index')
		else
			render 'new'
		end
	end
end
