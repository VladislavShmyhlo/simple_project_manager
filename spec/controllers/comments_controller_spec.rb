require 'spec_helper'

describe CommentsController do
  include_context 'valid session'

  let(:valid_attributes) { { "description" => "valid description" } }
  let(:valid_session) { {} }
  let(:project) { user.projects.create! name: 'name' }
  let(:task) { project.tasks.create! description: 'description' }
  let(:comment) { task.comments.create! body: 'body' }

  # TODO: rewrite this
  it "raises RecordNotFound" do
    expect {
      get :show, { id: 1 }, valid_session
    }.to raise_error(ActiveRecord::RecordNotFound)
  end
  # ====================================================================================================================
  describe "GET index" do
    before :each do
      get :index, { task_id: task.to_param }, valid_session
    end

    it "assigns task's comments as @comments" do
      expect(assigns(:comments)).to eq([comment])
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
      get :show, {id: comment.to_param}, valid_session
    end

    it "assigns the requested comment as @comment" do
      expect(assigns(:comment)).to eq(comment)
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
      let!(:params) { {comment: valid_attributes, task_id: task.to_param} }

      it "creates a new comment" do
        expect {
          post :create, params, valid_session
        }.to change(task.comments, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, params, valid_session
        expect(assigns(:comment)).to be_a(comment)
        expect(assigns(:comment)).to be_persisted
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
        Comment.any_instance.stub(:save).and_return(false)
      end

      let!(:params) { {comment: valid_attributes, task_id: task.to_param} }

      it "fails to create new comment" do
        Comment.any_instance.should_receive(:save)
        expect {
          post :create, params, valid_session
        }.to change(task.comments, :count).by(0)
      end

      it "assigns a newly created but unsaved comment as @comment" do
        post :create, params, valid_session
        expect(assigns(:comment)).to be_a_new(comment)
      end

      it "renders errors" do
        Comment.any_instance.should_receive(:errors).and_return('errors')
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
    let!(:params) { {id: comment.to_param, comment: valid_attributes} }

    describe "with valid params" do
      it "updates the requested comment" do
        Comment.any_instance.should_receive(:update).and_return(true)
        put :update, params, valid_session
      end

      it "assigns the requested comment as @comment" do
        put :update, params, valid_session
        assigns(:comment).should eq(comment)
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
        Comment.any_instance.stub(:update).and_return(false)
      end

      it "fails to update comment" do
        Comment.any_instance.should_receive(:update)
        put :update, params, valid_session
      end

      it "assigns the comment as @comment" do
        put :update, params, valid_session
        assigns(:comment).should eq(comment)
      end

      it "renders errors" do
        Comment.any_instance.should_receive(:errors).and_return('errors')
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
    let!(:params) { {id: comment.to_param} }

    describe "with successful destroy" do
      it "destroys the requested comment" do
        Comment.any_instance.should_receive(:destroy).and_call_original
        expect {
          delete :destroy, params, valid_session
        }.to change(task.comments, :count).by(-1)
      end

      it "assigns destroyed comment as @comment" do
        delete :destroy, params, valid_session
        expect(assigns(:comment)).to eq(comment)
        expect(assigns(:comment)).to be_destroyed
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
        Comment.any_instance.stub(:destroy).and_return(false)
      end

      it "fails to destroy comment" do
        Comment.any_instance.should_receive(:destroy)
        expect {
          delete :destroy, params, valid_session
        }.to change(task.comments, :count).by(0)
      end

      it "assigns not destroyed comment as @comment" do
        delete :destroy, params, valid_session
        expect(assigns(:comment)).to eq(comment)
        expect(assigns(:comment)).to_not be_destroyed
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
