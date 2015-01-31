class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :set_task, only: [:create]

  def index
    @comments = current_user.comments.includes(:attachments).where(tasks: {id: params[:task_id]}).all
    render 'index.json'
  end

  def show
    @comment = current_user.comments.includes(:attachments).find(params[:id])
    render 'show.json'
  end

  def create
    @comment = @task.comments.new(comment_params)

    if @comment.save
      render 'show.json'
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render 'show.json'
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private
    def set_task
      @task = current_user.tasks.find(params[:task_id])
    end

    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
