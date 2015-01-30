require "spec_helper"

describe Devise::ConfirmationsController do
  describe "routing" do
    it "routes to devise/confirmations#create" do
      post("/users/confirmation").should route_to("devise/confirmations#create")
    end
    
    it "routes to devise/confirmations#new" do
      get("/users/confirmation/new").should route_to("devise/confirmations#new")
    end
    
    it "routes to devise/confirmations#show" do
      get("/users/confirmation").should route_to("confirmations#show")
    end
  end
end