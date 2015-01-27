class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  # TODO: configure email sending
  # TODO: style login pages

  # TODO: integration, acceptance, functional testing

  # TODO: use shared contexts for acceptance tests

  private

  def redirect_if_not_json
    redirect_to root_path unless request.format == 'application/json'
  end
end
