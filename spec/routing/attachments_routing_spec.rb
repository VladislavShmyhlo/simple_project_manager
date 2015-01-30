require "spec_helper"

describe AttachmentsController do
  describe "routing" do
    it "routes to #index" do
      get("comments/1/attachments").should route_to("attachments#index", comment_id: '1')
    end

    it "fails to route to #new" do
      get("/comments/1/attachments/new").should_not be_routable
    end

    it "routes to #show" do
      get("/comments/1/attachments/1").should route_to("attachments#show", id: '1', comment_id: '1')
    end

    it "fails to route to #edit" do
      get("/comments/1/attachments/1/edit").should_not be_routable
    end

    it "routes to #create" do
      post("/comments/1/attachments").should route_to("attachments#create", comment_id: '1')
    end

    it "routes to #update" do
      put("/comments/1/attachments/1").should route_to("attachments#update", id: '1', comment_id: '1')
    end

    it "routes to #destroy" do
      delete("/comments/1/attachments/1").should route_to("attachments#destroy", id: '1', comment_id: '1')
    end
  end
end
