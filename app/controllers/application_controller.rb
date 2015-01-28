class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  # TODO: style login pages
  # TODO: add form errors to all forms
  # TODO: integration, acceptance, functional testing
  # TODO: fix views
  # TODO: how application will respond in production to wrong request format?
  # TODO: move throbber to container
  # TODO: implement confirmation skipping for ouath
  # TODO: check default url options for sending mail
  private

  # def redirect_if_not_json
  #   redirect_to root_path unless request.format == 'application/json'
  # end
end
