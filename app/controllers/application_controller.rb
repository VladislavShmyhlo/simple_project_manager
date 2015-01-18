class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :redirect_to_home
  # before_action :authenticate_user!
  before_action :check_user

  private

  def check_user
    redirect_to root_path unless user_signed_in?
  end

  def redirect_to_home
    unless request.format == 'application/json'
      redirect_to root_path
    end
  end
end
