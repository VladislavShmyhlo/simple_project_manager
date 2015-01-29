require 'spec_helper'

describe TasksController do
  include_context 'valid session'

  let(:valid_attributes) { { "description" => "valid description" } }
  let(:valid_session) { {} }
  let(:project) { FactoryGirl.create(:project, user: user)}
  let(:task) { FactoryGirl.create(:task, project: project) }

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

    it "assigns project's tasks as @tasks" do
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
      get :show, {id: task.to_param}, valid_session
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
      let!(:params) { {task: valid_attributes, project_id: project.to_param} }

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

      let!(:params) { {task: valid_attributes, project_id: project.to_param} }

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
    let!(:params) { {id: task.to_param, task: valid_attributes} }

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
  describe "DELETE destroy" do
    let!(:params) { {id: task.to_param} }

    describe "with successful destroy" do
      it "destroys the requested task" do
        Task.any_instance.should_receive(:destroy).and_call_original
        expect {
          delete :destroy, params, valid_session
        }.to change(project.tasks, :count).by(-1)
      end

      it "assigns destroyed task as @task" do
        delete :destroy, params, valid_session
        expect(assigns(:task)).to eq(task)
        expect(assigns(:task)).to be_destroyed
      end

      it "responds with 204" do
        delete :destroy, params, valid_session
        expect(response.status).to eq(204)
      end

      it "renders nothing" do
        expect(response.body).to be_empty
      end
    end

    describe "with failed destroy" do
      before :each do
        Task.any_instance.stub(:destroy).and_return(false)
      end

      it "fails to destroy task" do
        Task.any_instance.should_receive(:destroy)
        expect {
          delete :destroy, params, valid_session
        }.to change(project.tasks, :count).by(0)
      end

      it "assigns not destroyed task as @task" do
        delete :destroy, params, valid_session
        expect(assigns(:task)).to eq(task)
        expect(assigns(:task)).to_not be_destroyed
      end

      it "responds with 422" do
        delete :destroy, params, valid_session
        expect(response.status).to eq(422)
      end

      it "renders nothing" do
        expect(response.body).to be_empty
      end
    end
  end
end
