require 'spec_helper'

describe TasksController do
  include_context 'valid session'

  let(:valid_attributes) { { "description" => "valid description" } }
  let(:valid_session) { {} }
  let(:project) { user.projects.create! name: 'name' }
  let(:task) { project.tasks.create! description: 'description' }

  # TODO: rewrite this
  it "raises RecordNotFound" do
    expect {
      get :show, { id: 1 }, valid_session
    }.to raise_error(ActiveRecord::RecordNotFound)
  end
  # ====================================================================================================================
  describe "GET index" do
    before :each do
      get :index, { project_id: project.to_param }, valid_session
    end

    it "assigns all tasks as @tasks" do
      expect(assigns(:tasks)).to eq([task])
    end

    it "renders the index.json template" do
      expect(response).to render_template('index.json')
    end

    it "is successful" do
      expect(response.status).to eq(200)
    end
  end
  # ====================================================================================================================
  describe "GET show" do
    before :each do
      get :show, {id: task.to_param, project_id: project.to_param}, valid_session
    end

    it "assigns the requested task as @task" do
      expect(assigns(:task)).to eq(task)
    end

    it "renders the show.json template" do
      expect(response).to render_template('show.json')
    end

    it "is successful" do
      expect(response.status).to eq(200)
    end
  end
  # ====================================================================================================================
  describe "POST create" do
    describe "with valid params" do
      let(:params) { {task: valid_attributes, project_id: project.to_param} }

      it "creates a new task" do
        expect {
          post :create, params, valid_session
        }.to change(project.tasks, :count).by(1)
      end

      it "assigns a newly created task as @task" do
        post :create, params, valid_session
        expect(assigns(:task)).to be_a(Task)
        expect(assigns(:task)).to be_persisted
      end

      it "renders the show.json template" do
        post :create, params, valid_session
        expect(response).to render_template('show.json')
      end

      it "is successful" do
        post :create, params, valid_session
        expect(response.status).to eq(200)
      end
    end

    describe "with invalid params" do
      before :each do
        Task.any_instance.stub(:save).and_return(false)
      end

      let(:params) { {task: valid_attributes, project_id: project.to_param} }

      it "fails to create new task" do
        Task.any_instance.should_receive(:save)
        expect {
          post :create, params, valid_session
        }.to change(project.tasks, :count).by(0)
      end

      it "assigns a newly created but unsaved task as @task" do
        post :create, params, valid_session
        expect(assigns(:task)).to be_a_new(Task)
      end

      it "renders errors" do
        Task.any_instance.should_receive(:errors).and_return('errors')
        post :create, params, valid_session
        expect(response.body).to eq('errors')
      end

      it "responds with 422" do
        post :create, params, valid_session
        expect(response.status).to eq(422)
      end
    end
  end
  # ====================================================================================================================
  describe "PUT update" do
    # here let MUST be with bang!
    let!(:params) { {id: task.to_param, task: valid_attributes, project_id: project.to_param } }

    describe "with valid params" do
      it "updates the requested task" do
        Task.any_instance.should_receive(:update).and_return(true)
        put :update, params, valid_session
      end

      it "assigns the requested task as @task" do
        put :update, params, valid_session
        assigns(:task).should eq(task)
      end

      it "renders show.json" do
        put :update, params, valid_session
        expect(response).to render_template('show.json')
      end

      it "is successful" do
        put :update, params, valid_session
        expect(response.status).to eq(200)
      end
    end

    describe "with invalid params" do
      before :each do
        Task.any_instance.stub(:update).and_return(false)
      end

      it "fails to update task" do
        Task.any_instance.should_receive(:update)
        put :update, params, valid_session
      end

      it "assigns the task as @task" do
        put :update, params, valid_session
        assigns(:task).should eq(task)
      end

      it "renders errors" do
        Task.any_instance.should_receive(:errors).and_return('errors')
        put :update, params, valid_session
        expect(response.body).to eq('errors')
      end

      it "responds with 422" do
        put :update, params, valid_session
        expect(response.status).to eq(422)
      end
    end
  end
  # # ====================================================================================================================
  # describe "DELETE destroy" do
  #   it "renders nothing" do
  #     expect(response.body).to be_empty
  #   end
  #
  #   # TODO: "with successful destroy" ?
  #   describe "with successful destroy" do
  #     # TODO: this doesnt work for some reason
  #     it "destroys the requested project" do
  #       project = user.projects.create! valid_attributes
  #       Project.any_instance.should_receive(:destroy).and_call_original
  #
  #       expect {
  #         delete :destroy, {:id => project.to_param}, valid_session
  #       }.to change(user.projects, :count).by(-1)
  #     end
  #
  #     it "assigns destroyed project as @project" do
  #       delete :destroy, {:id => project.to_param}, valid_session
  #       expect(assigns(:project)).to eq(project)
  #       expect(assigns(:project)).to be_destroyed
  #     end
  #
  #     it "responds with 204" do
  #       delete :destroy, {:id => project.to_param}, valid_session
  #       expect(response.status).to eq(204)
  #     end
  #   end
  #   # TODO: "with failed destroy" ?
  #   describe "with failed destroy" do
  #     before :each do
  #       Project.any_instance.stub(:destroy).and_return(false)
  #     end
  #     it "fails to destroy project" do
  #       # TODO: return value doesn't work at all
  #       Project.any_instance.should_receive(:destroy).and_return(false)
  #       project = user.projects.create! valid_attributes
  #       expect {
  #         delete :destroy, {:id => project.to_param}, valid_session
  #       }.to change(user.projects, :count).by(0)
  #     end
  #
  #     it "assigns not destroyed project as @project" do
  #       delete :destroy, {:id => project.to_param}, valid_session
  #       expect(assigns(:project)).to eq(project)
  #       expect(assigns(:project)).to_not be_destroyed
  #     end
  #
  #     it "responds with 422" do
  #       delete :destroy, {:id => project.to_param}, valid_session
  #       expect(response.status).to eq(422)
  #     end
  #   end
  # end
end
