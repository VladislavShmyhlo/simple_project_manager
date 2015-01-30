require "spec_helper"

describe Users::OmniauthCallbacksController do
  describe "routing" do
    it "routes to users/omniauth_callbacks#passthru" do
      post("/users/auth/facebook").should route_to("users/omniauth_callbacks#passthru", provider: 'facebook')
    end

    it "fails to route to users/omniauth_callbacks#passthru" do
      post("/users/auth/twitter").should_not route_to("users/omniauth_callbacks#passthru", provider: 'twitter')
    end

    it "routes to users/omniauth_callbacks#facebook" do
      get("/users/auth/facebook/callback").should route_to("users/omniauth_callbacks#facebook", action: 'facebook')
    end
  end
end