require 'spec_helper'

describe AttachmentsController do
  include_context 'valid session'

  let(:valid_session) { {} }
  let(:valid_attributes) { {"file" => fixture_file_upload(File.join('files', 'file.txt'), 'text/plain')} }
  let(:project) { FactoryGirl.create(:project, user: user)}
  let(:task) { FactoryGirl.create(:task, project: project) }
  let(:comment) { FactoryGirl.create(:comment, task: task) }
  let(:attachment) { FactoryGirl.create(:attachment, comment: comment) }

  it "raises RecordNotFound" do
    expect {
      get :show, { comment_id: comment.to_param, id: 1 }, valid_session
    }.to raise_error(ActiveRecord::RecordNotFound)
  end
  # ====================================================================================================================
  describe "GET index" do
    before :each do
      get :index, { comment_id: comment.to_param }, valid_session
    end

    it "assigns comment's attachments as @attachments" do
      expect(assigns(:attachments)).to eq([attachment])
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
      get :show, { comment_id: comment.to_param, id: attachment.to_param}, valid_session
    end

    it "assigns the requested attachment as @attachment" do
      expect(assigns(:attachment)).to eq(attachment)
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
      let!(:params) { {attachment: valid_attributes, comment_id: comment.to_param} }

      it "creates a new attachment" do
        expect {
          post :create, params, valid_session
        }.to change(comment.attachments, :count).by(1)
      end

      it "assigns a newly created attachment as @attachment" do
        post :create, params, valid_session
        expect(assigns(:attachment)).to be_a(Attachment)
        expect(assigns(:attachment)).to be_persisted
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
        Attachment.any_instance.stub(:save).and_return(false)
      end

      let!(:params) { {attachment: 'string', comment_id: comment.to_param} }

      it "fails to create new attachment" do
        Attachment.any_instance.should_receive(:save)
        expect {
          post :create, params, valid_session
        }.to change(comment.attachments, :count).by(0)
      end

      it "assigns a newly created but unsaved attachment as @attachment" do
        post :create, params, valid_session
        expect(assigns(:attachment)).to be_a_new(Attachment)
      end

      it "renders errors" do
        Attachment.any_instance.should_receive(:errors).and_return('errors')
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
    let!(:params) { {comment_id: comment.to_param, id: attachment.to_param, attachment: valid_attributes} }

    describe "with valid params" do
      it "updates the requested attachment" do
        Attachment.any_instance.should_receive(:update).and_return(true)
        put :update, params, valid_session
      end

      it "assigns the requested attachment as @attachment" do
        put :update, params, valid_session
        assigns(:attachment).should eq(attachment)
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
        Attachment.any_instance.stub(:update).and_return(false)
      end

      it "fails to update attachment" do
        Attachment.any_instance.should_receive(:update)
        put :update, params, valid_session
      end

      it "assigns the attachment as @attachment" do
        put :update, params, valid_session
        assigns(:attachment).should eq(attachment)
      end

      it "renders errors" do
        Attachment.any_instance.should_receive(:errors).and_return('errors')
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
    let!(:params) { {comment_id: comment.to_param, id: attachment.to_param} }

    describe "with successful destroy" do
      it "destroys the requested attachment" do
        Attachment.any_instance.should_receive(:destroy).and_call_original
        expect {
          delete :destroy, params, valid_session
        }.to change(comment.attachments, :count).by(-1)
      end

      it "assigns destroyed attachment as @attachment" do
        delete :destroy, params, valid_session
        expect(assigns(:attachment)).to eq(attachment)
        expect(assigns(:attachment)).to be_destroyed
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
        Attachment.any_instance.stub(:destroy).and_return(false)
      end

      it "fails to destroy attachment" do
        Attachment.any_instance.should_receive(:destroy)
        expect {
          delete :destroy, params, valid_session
        }.to change(comment.attachments, :count).by(0)
      end

      it "assigns not destroyed attachment as @attachment" do
        delete :destroy, params, valid_session
        expect(assigns(:attachment)).to eq(attachment)
        expect(assigns(:attachment)).to_not be_destroyed
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
