class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :set_project, only: [:create, :update_all]

  respond_to :json

  def index
    @tasks = Task.all
    respond_with(@tasks)
  end

  def show
    @task = Task.includes(comments: :attachments).find(params[:id])
  end

  def new
    @task = Task.new
    respond_with(@task)
  end

  def edit
  end

  def create
    @task = @project.tasks.build(task_params)
    respond_to {|format|
      if @task.save
        format.json { render :show }
      end
    }
  end

  def update
    @task.update(task_params)
    respond_with(@task)
  end

  def update_all
    @project.tasks.update(tasks_params)
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:description, :completed)
    end

    def tasks_params
      params.require(:tasks).permit(:description, :completed, :id, :position)
    end
end
