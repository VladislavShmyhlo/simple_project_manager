require "spec_helper"

describe Devise::RegistrationsController do
  describe "routing" do
    it "routes to devise/registrations#create" do
      get("/users/cancel").should route_to("devise/registrations#cancel")
    end
    
    it "routes to devise/registrations#new" do
      post("/users").should route_to("devise/registrations#create")
    end
    
    it "routes to devise/registrations#dit" do
      get("/users/sign_up").should route_to("devise/registrations#new")
    end
    
    it "routes to devise/registrations#update" do
      get("/users/edit").should route_to("devise/registrations#edit")
    end
    
    it "routes to devise/registrations#update" do
      patch("/users").should route_to("devise/registrations#update")
    end
    
    it "routes to devise/registrations#update" do
      put("/users").should route_to("devise/registrations#update")
    end
    
    it "routes to devise/registrations#update" do
      delete("/users").should route_to("devise/registrations#destroy")
    end
  end
end