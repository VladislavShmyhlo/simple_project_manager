class StaticController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    render :index, layout: false
  end
end