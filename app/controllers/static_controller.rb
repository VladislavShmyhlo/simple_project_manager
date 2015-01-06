class StaticController < ApplicationController
  def index
    render text: '', layout: true
  end
end
