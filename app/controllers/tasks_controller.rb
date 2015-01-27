class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]
  before_action :set_project, only: [:create]

  def index
    @tasks = current_user.tasks.where(projects: {id: params[:project_id]}).all
    render 'index.json'
  end

  def show
    @task = current_user.tasks.includes(comments: :attachments).find(params[:id])
    render 'show.json'
  end

  def create
    @task = @project.tasks.new(task_params)

    if @task.save
      render 'show.json'
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render 'show.json'
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      head :no_content
    else
      # TODO: implement error response
      # head :no_content
      head :unprocessable_entity
    end
  end

  private
    def set_project
      @project = current_user.projects.find(params[:project_id])
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:description, :completed, :position, :deadline)
    end
end
