class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  # def after_sign_in_path_for(resource_or_scope)
  #   if request.env['omniauth.origin']
  #     request.env['omniauth.origin']
  #   end
  # end

  private

  # def redirect_to_home
  #   unless request.format == 'application/json'
  #     redirect_to root_path
  #   end
  # end
end
