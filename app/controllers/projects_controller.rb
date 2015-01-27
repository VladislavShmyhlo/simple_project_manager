class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # respond_to :json

  def index
    @projects = current_user.projects.includes(:tasks).all
    render 'index.json'
  end

  def show
    render 'show.json'
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save(project_params)
      render 'show.json'
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render 'show.json'
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      head :no_content
    else
      # TODO: implement error response
      # head :no_content
      head :unprocessable_entity
    end
  end

  private
  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, tasks_attributes: [:id, :description, :completed, :position, :deadline])
  end
end
