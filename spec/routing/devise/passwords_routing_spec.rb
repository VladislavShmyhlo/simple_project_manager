require "spec_helper"

describe Devise::PasswordsController do
  describe "routing" do
    it "routes to devise/password#create" do
      post("/users/password").should route_to("devise/password#create")
    end
    
    it "routes to devise/password#new" do
      get("/users/password/new").should route_to("devise/password#new")
    end
    
    it "routes to devise/passwords#dit" do
      get("/users/password/edit").should route_to("devise/passwords#dit")
    end
    
    it "routes to devise/passwords#update" do
      patch("/users/password").should route_to("devise/passwords#update")
    end
    
    it "routes to devise/passwords#update" do
      put("/users/password").should route_to("devise/passwords#update")
    end
  end
end