class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @attachments = Attachment.all
    respond_with(@attachments)
  end

  def show
    respond_with(@attachment)
  end

  def new
    @attachment = Attachment.new
    respond_with(@attachment)
  end

  def edit
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @attachment = @comment.attachments.build(attachment_params)
    if @attachment.save
      render :show
    end
  end

  def update
    @attachment.update(attachment_params)
    respond_with(@attachment)
  end

  def destroy
    @attachment.destroy
    respond_with(@attachment)
  end

  private
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    def attachment_params
      params.require(:attachment).permit(:file)
    end
end
