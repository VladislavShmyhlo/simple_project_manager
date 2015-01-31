class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  # TODO: redirect after signout
  # TODO: style login pages
  # TODO: integration, acceptance, functional testing
  # TODO: how application will respond in production to wrong request format?
  # TODO: check default url options for sending mail
  # TODO: change mail sender
  # TODO: check delivery errors in production

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
