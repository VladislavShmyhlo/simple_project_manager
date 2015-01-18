class StaticController < ApplicationController
  skip_before_action :authenticate_user!
  # skip_before_action :redirect_to_home

  def index
    render :index, layout: false
  end
end 