require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ProjectsController do

  # This should return the minimal set of attributes required to create a valid
  # Project. As you add validations to Project, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { name: "MyString" } }
  let(:invalid_attributes) { { name: "s" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProjectsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:user) { FactoryGirl.create :user }

  before :each do
    sign_in user
  end

  describe "GET index" do
    let(:project) { user.projects.create valid_attributes }

    before :each do
      get :index, {}, valid_session
    end

    it "assigns all projects as @projects" do
      expect(assigns(:projects)).to include(project)
    end

    it "renders the index.json template" do
      expect(response).to render_template('index.json')
    end

    it "is successful" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET show" do
    let(:project) { user.projects.create valid_attributes }

    before :each do
      get :show, {id: project.to_param}, valid_session
    end

    it "assigns the requested project as @project" do
      expect(assigns(:project)).to eq(project)
    end

    it "renders the show.json template" do
      expect(response).to render_template('show.json')
    end

    it "is successful" do
      expect(response.status).to eq(200)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, {:project => valid_attributes}, valid_session
        }.to change(user.projects, :count).by(1)
      end

      it "assigns a newly created project as @project" do
        post :create, {:project => valid_attributes}, valid_session
        expect(assigns(:project)).to be_a(Project)
        expect(assigns(:project)).to be_persisted
      end

      it "renders the show.json template" do
        post :create, {:project => valid_attributes}, valid_session
        expect(response).to render_template('show.json')
      end

      it "is successful" do
        post :create, {:project => valid_attributes}, valid_session
        expect(response.status).to eq(200)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project" do
        # Trigger the behavior that occurs when invalid params are submitted

        # Project.any_instance.stub(:save).and_return(false)

        post :create, {:project => invalid_attributes}, valid_session
        assigns(:project).should be_a_new(Project)
      end

      it "renders errors" do
        # Trigger the behavior that occurs when invalid params are submitted

        # project = Project.any_instance.stub(:errors).and_return(false)

        post :create, {:project => invalid_attributes}, valid_session
        # TODO: find out how to expect render project.errors
        expect(response.body).to have_content 'is too short'
      end

      it "responds with 422" do
        # project = Project.any_instance.stub(:save).and_return(false)

        post :create, {:project => invalid_attributes}, valid_session
        expect(response.status).to eq(422)
      end
    end
  end
  #
  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested project" do
  #       project = Project.create! valid_attributes
  #       # Assuming there are no other projects in the database, this
  #       # specifies that the Project created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       Project.any_instance.should_receive(:update).with({ "name" => "MyString" })
  #       put :update, {:id => project.to_param, :project => { "name" => "MyString" }}, valid_session
  #     end
  #
  #     it "assigns the requested project as @project" do
  #       project = Project.create! valid_attributes
  #       put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
  #       assigns(:project).should eq(project)
  #     end
  #
  #     it "redirects to the project" do
  #       project = Project.create! valid_attributes
  #       put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
  #       response.should redirect_to(project)
  #     end
  #   end
  #
  #   describe "with invalid params" do
  #     it "assigns the project as @project" do
  #       project = Project.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Project.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => project.to_param, :project => { "name" => "invalid value" }}, valid_session
  #       assigns(:project).should eq(project)
  #     end
  #
  #     it "re-renders the 'edit' template" do
  #       project = Project.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Project.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => project.to_param, :project => { "name" => "invalid value" }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end
  #
  # describe "DELETE destroy" do
  #   it "destroys the requested project" do
  #     project = Project.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => project.to_param}, valid_session
  #     }.to change(Project, :count).by(-1)
  #   end
  #
  #   it "redirects to the projects list" do
  #     project = Project.create! valid_attributes
  #     delete :destroy, {:id => project.to_param}, valid_session
  #     response.should redirect_to(projects_url)
  #   end
  # end

end
