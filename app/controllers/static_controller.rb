class StaticController < ApplicationController
  # skip_before_action :authenticate_user!
  skip_before_action :redirect_to_home
  skip_before_action :check_user

  def index
    render text: '', layout: 'application'
  end
end
