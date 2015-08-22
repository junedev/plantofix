class TasksController < ApplicationController
  before_action :authenticate
  # Save new task to database
  # POST /tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      render partial: "boards/task", locals: {task: @task}, status: :created
    else
      redirect_to "/boards/#{get_current_board["id"]}", alert: 'Task could not be created.'
    end
  end

  # PATCH/PUT /tasks/1
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      if request.xhr?
        @task = Task.find(params[:id])
        render json: @task, status: :ok
      else
        redirect_to "/boards/#{get_current_board["id"]}"
      end
    else
      redirect_to "/boards/#{get_current_board["id"]}", alert: 'Task could not be updated.'
    end
  end

  # DELETE /tasks/1
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    if request.xhr? 
      render nothing: true, status: :ok
    else
      redirect_to "/boards/#{get_current_board["id"]}"
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :list_id, :assignee_id, :color, :position, :description)
    end
end
