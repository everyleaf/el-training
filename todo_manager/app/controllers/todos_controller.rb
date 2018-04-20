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
			redirect_to('/')
		else
			render 'new'
		end
	end

	def detail
		@todo = Todo.find_by(id: params[:id])
	end

	def edit
		@todo = Todo.find_by(id: params[:id])
	end	

	def update
		@todo = Todo.find_by(id: params[:id])
		@todo.title = params[:title]
		@todo.content = params[:content]
		if @todo.save
			flash[:notice] = "Todo has been updated."
			redirect_to("/todos/#{@todo.id}/detail")
		else
			render 'edit'
		end
	end

	def destroy
		@todo = Todo.find_by(id: params[:id])
		@todo.destroy
		flash[:notice] = "Todo has been deleted."
		redirect_to("/")
	end
end
