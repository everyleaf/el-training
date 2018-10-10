class TaskLabelsController < ApplicationController
  before_action :set_task_label, only: [:show, :edit, :update, :destroy]

  # GET /task_labels
  # GET /task_labels.json
  def index
    @task_labels = TaskLabel.all
  end

  # GET /task_labels/1
  # GET /task_labels/1.json
  def show
  end

  # GET /task_labels/new
  def new
    @task_label = TaskLabel.new
  end

  # GET /task_labels/1/edit
  def edit
  end

  # POST /task_labels
  # POST /task_labels.json
  def create
    @task_label = TaskLabel.new(task_label_params)

    respond_to do |format|
      if @task_label.save
        format.html { redirect_to @task_label, notice: 'Task label was successfully created.' }
        format.json { render :show, status: :created, location: @task_label }
      else
        format.html { render :new }
        format.json { render json: @task_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_labels/1
  # PATCH/PUT /task_labels/1.json
  def update
    respond_to do |format|
      if @task_label.update(task_label_params)
        format.html { redirect_to @task_label, notice: 'Task label was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_label }
      else
        format.html { render :edit }
        format.json { render json: @task_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_labels/1
  # DELETE /task_labels/1.json
  def destroy
    @task_label.destroy
    respond_to do |format|
      format.html { redirect_to task_labels_url, notice: 'Task label was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_label
      @task_label = TaskLabel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_label_params
      params.require(:task_label).permit(:task_id, :label_id)
    end
end
