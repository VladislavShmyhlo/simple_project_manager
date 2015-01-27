class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :update, :destroy]
  before_action :set_comment, only: [:create]

  def index
    @attachments = current_user.attachments.where(comments: {id: params[:comment_id]})
    render 'index.json'
  end

  def show
    render 'show.json'
  end

  def create
    @attachments = @comment.attachments.new(attachment_params)

    if @attachment.save
      render 'show.json'
    else
      render json: @attachment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @attachment.update(attachment_params)
      render 'show.json'
    else
      render json: @attachment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @attachment.destroy
      head :no_content
    else
      # TODO: implement error response
      # head :no_content
      head :unprocessable_entity
    end
  end

  private
    def set_comment
      @comment = current_user.comments.find(params[:comment_id])
    end

    def set_attachment
      @attachment = current_user.attachments.find(params[:id])
    end

    def attachment_params
      params.require(:attachment).permit(:file)
    end
end
