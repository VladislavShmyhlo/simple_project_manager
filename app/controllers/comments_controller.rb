class CommentsController < ApplicationController
  before_action :redirect_if_not_json
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_task, only: [:create, :update]

  respond_to :json

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @comment = @task.comments.new(comment_params)
    if @comment.save
      render 'show.json'
    else
      # render head: :no_content, status: 500
    end
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment.destroy
    respond_with(@comment)
  end

  private
    def set_task
      @task = Task.find(params[:task_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
