class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :authenticate_user!
  # before_action :redirect_to_home

  private

  def redirect_to_home
    unless request.format == 'application/json'
      redirect_to root_path
    end
  end
end
