require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #index" do
      get("/comments").should route_to("comments#index")
      get("/tasks/1/comments").should route_to("comments#index", task_id: '1')
    end

    it "fails to route to #new" do
      get("/comments/new").should_not be_routable
      get("/tasks/1/comments/new").should_not be_routable
    end

    it "routes to #show" do
      get("/comments/1").should route_to("comments#show", id: '1')
      get("/tasks/1/comments/1").should route_to("comments#show", id: '1', task_id: '1')
    end

    it "fails to route to #edit" do
      get("/comments/1/edit").should_not be_routable
      get("/tasks/1/comments/1/edit").should_not be_routable
    end

    it "routes to #create" do
      post("/comments").should route_to("comments#create")
      post("/tasks/1/comments").should route_to("comments#create", task_id: '1')
    end

    it "routes to #update" do
      put("/comments/1").should route_to("comments#update", id: '1')
      put("/tasks/1/comments/1").should route_to("comments#update", id: '1', task_id: '1')
    end

    it "routes to #destroy" do
      delete("/comments/1").should route_to("comments#destroy", id: '1')
      delete("/tasks/1/comments/1").should route_to("comments#destroy", id: '1', task_id: '1')
    end
  end
end
