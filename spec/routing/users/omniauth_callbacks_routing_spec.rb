require "spec_helper"

describe Users::OmniauthCallbacksController do
  describe "routing" do
    it "routes to users/omniauth_callbacks#passthru" do
      post("/users/auth/facebook").should route_to("users/omniauth_callbacks#passthru", provider: 'facebook')
    end

    it "fails to route to users/omniauth_callbacks#passthru" do
      post("/users/auth/twitter").should_not route_to("users/omniauth_callbacks#passthru", provider: 'twitter')
    end
    
    it "routes to users/omniauth_callbacks#show" do
      get("/users/auth/show/callback").should route_to("users/omniauth_callbacks#show", action: 'show')
    end
  end
end

# user_omniauth_authorize GET|POST /users/auth/:provider(.:format)                 users/omniauth_callbacks#passthru {:provider=>/facebook/}
# user_omniauth_callback GET|POST /users/auth/:action/callback(.:format)          users/omniauth_callbacks#:action
