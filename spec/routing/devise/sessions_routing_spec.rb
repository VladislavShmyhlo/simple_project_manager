require "spec_helper"

describe Devise::SessionsController do
  describe "routing" do
    it "routes to devise/sessions#index" do
      get("/users/sign_in").should route_to("devise/sessions#new")
    end

    it "routes to devise/sessions#create" do
      post("/users/sign_in").should route_to('devise/sessions#create')
    end

    it "routes to devise/sessions#destroy" do
      get("/users/sign_out").should route_to("devise/sessions#destroy")
    end
  end
end