class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  # TODO: style login pages
  # TODO: style statuc and errors
  # TODO: change mail sender

  private

  # Overwriting the sign_out redirect path method
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope == :user
      root_path
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      new_user_session_path
    else
      super
    end
  end
end
