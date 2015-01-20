class ProjectsController < ApplicationController
  # before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @projects = current_user.projects.includes(:tasks).all
    render 'index.json'
  end

  def show
    respond_with(@project)
  end

  # def new
  #   @project = Project.new
  #   respond_with(@project)
  # end
  #
  # def edit
  # end

  def create
    @project = Project.new(project_params)
    respond_to do|format|
      if @project.save(project_params)
        format.json { render :show }
      else
        format.json { render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do|format|
      if @project.update(project_params)
        format.json { render :show }
      else
        format.json { render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @project.destroy
        format.json { head :no_content }
      else
        format.json { head :no_content }
      end
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, tasks_attributes: [:id, :position])
    end
end
