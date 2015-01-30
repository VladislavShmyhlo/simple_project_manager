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
end
