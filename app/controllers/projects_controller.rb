class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # kind of restful way of rendering responses

  def index
    # @projects = current_user.projects.eager_load(:tasks).all
    @projects = current_user.projects.includes(:tasks).all
    render 'index.json'
  end

  def show
    render 'show.json'
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
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
