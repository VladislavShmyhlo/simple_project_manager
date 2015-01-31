require 'spec_helper'

describe Users::OmniauthCallbacksController do
    pending 'need to be implemented'
end






 it "routes to users/omniauth_callbacks#facebook" do
      get("/users/auth/facebook/callback").should route_to("users/omniauth_callbacks#facebook", action: 'facebook')
    end