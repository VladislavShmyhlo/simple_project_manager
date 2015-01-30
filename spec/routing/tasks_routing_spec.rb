require "spec_helper"

describe TasksController do
  describe "routing" do
    it "routes to #index" do
      get("/tasks").should route_to("tasks#index")
      get('/projects/1/tasks').should route_to('tasks#index', project_id: '1')
    end

    it "fails to route to #new" do
      get("/tasks/new").should_not be_routable
      get("/projects/1/tasks/new").should_not be_routable
    end

    it "routes to #show" do
      get("/tasks/1").should route_to("tasks#show", id: '1')
      get("/projects/1/tasks/1").should route_to("tasks#show", id: '1', project_id: '1')
    end

    it "fails to route to #edit" do
      get("/tasks/1/edit").should_not be_routable
      get("/projects/1/tasks/1/edit").should_not be_routable
    end

    it "routes to #create" do
      post("/tasks").should route_to("tasks#create")
      post("/projects/1/tasks").should route_to("tasks#create", project_id: '1')
    end

    it "routes to #update" do
      put("/tasks/1").should route_to("tasks#update", id: '1')
      put("/projects/1/tasks/1").should route_to("tasks#update", id: '1', project_id: '1')
    end

    it "routes to #destroy" do
      delete("/tasks/1").should route_to("tasks#destroy", id: '1')
      delete("/projects/1/tasks/1").should route_to("tasks#destroy", id: '1', project_id: '1')
    end
  end
end
