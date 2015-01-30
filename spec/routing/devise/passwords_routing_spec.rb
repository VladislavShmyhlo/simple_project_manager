require "spec_helper"

describe Devise::PasswordsController do
  describe "routing" do
    it "routes to devise/passwords#create" do
      post("/users/password").should route_to("devise/passwords#create")
    end

    it "routes to devise/passwords#new" do
      get("/users/password/new").should route_to("devise/passwords#new")
    end

    it "routes to devise/passwords#dit" do
      get("/users/password/edit").should route_to("devise/passwords#edit")
    end

    it "routes to devise/passwords#update" do
      patch("/users/password").should route_to("devise/passwords#update")
    end

    it "routes to devise/passwords#update" do
      put("/users/password").should route_to("devise/passwords#update")
    end
  end
end