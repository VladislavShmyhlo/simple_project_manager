class StaticController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    render text: '', layout: true
  end
end
