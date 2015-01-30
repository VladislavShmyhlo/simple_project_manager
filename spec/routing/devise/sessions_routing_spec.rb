require "spec_helper"

describe Devise::SessionsController do
  describe "routing" do
    it "routes to devise/sessions#index" do
      get("users/sign_in").should route_to("devise/sessions#new")
    end

    it "routes to devise/sessions#create" do
      post("/comments/1/attachments/new").should route_to('devise/sessions#create')
    end

    it "routes to devise/sessions#destroy" do
      get("/comments/1/attachments/1").should route_to("devise/sessions#destrou")
    end
  end
end