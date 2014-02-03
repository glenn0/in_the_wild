require 'spec_helper'

describe ProjectsController do
  describe "POST create" do
    context "with authenticated user" do
      context "with valid inputs" do
        let(:post_valid_inputs_with_user) do
          sign_in Fabricate(:user)
          post :create, project: Fabricate.attributes_for(:project)
        end
        it "creates a project" do
          expect{post_valid_inputs_with_user}.to change(Project, :count).by(1)
        end
        it "creates a project associated with the signed in user" do
          user = Fabricate(:user)
          sign_in user
          post :create, project: Fabricate.attributes_for(:project)
          expect(Project.first.users).to include(user)
        end
        it "redirects to the pages home page" do
          post_valid_inputs_with_user
          expect(response).to redirect_to home_path
        end
        it "sets the flash success message" do
          post_valid_inputs_with_user
          expect(flash[:notice]).to be_present
        end
      end
      context "with invalid URL inputs" do
        let(:post_invalid_url_inputs_with_user) do
          sign_in Fabricate(:user)
          post :create, project: { url: "http://sourceforge.net/projects/minsky/" }
        end
        it "doesn't create a project" do
          expect{post_invalid_url_inputs_with_user}.to change(Project, :count).by(0)
        end
        it "redirects to the pages home page" do
          post_invalid_url_inputs_with_user
          expect(response).to redirect_to home_path
        end
        it "sets the flash error message" do
          post_invalid_url_inputs_with_user
          expect(flash[:error]).to be_present
        end
      end
      context "with non-URL inputs" do
        let(:post_non_url_inputs_with_user) do
          sign_in Fabricate(:user)
          post :create, project: { url: "icanhazcheezburger" }
        end
        it "doesn't create a project" do
          expect{post_non_url_inputs_with_user}.to change(Project, :count).by(0)
        end
        it "redirects to the pages home page" do
          post_non_url_inputs_with_user
          expect(response).to redirect_to home_path
        end
        it "sets the flash error message" do
          post_non_url_inputs_with_user
          expect(flash[:error]).to be_present
        end
      end
      context "with no inputs" do
        let(:post_no_inputs_with_user) do
          sign_in Fabricate(:user)
          post :create, project: { url: "" }
        end
        it "doesn't create a project" do
          expect{post_no_inputs_with_user}.to change(Project, :count).by(0)
        end
        it "redirects to the pages home page" do
          post_no_inputs_with_user
          expect(response).to redirect_to home_path
        end
        it "sets the flash error message" do
          post_no_inputs_with_user
          expect(flash[:error]).to be_present
        end
      end
    end
    context "with unauthenticated user" do
      let(:post_valid_inputs_no_user) { post :create, project: Fabricate.attributes_for(:project) }
      it "doesn't create a project" do
        expect{post_valid_inputs_no_user}.to change(Project, :count).by(0)
      end
      it "redirects to the pages home page" do
        post_valid_inputs_no_user
        expect(response).to redirect_to user_session_path
      end
      it "sets the flash error message" do
        post_valid_inputs_no_user
        expect(flash[:alert]).to be_present
      end
    end
  end
  describe "POST vote" do
    context "with authenticated user" do
      it "redirects to home path" do
        sign_in Fabricate(:user)
        project = Fabricate(:project)
        post :vote, id: project.id, vote: true
        expect(response).to redirect_to home_path
      end
      it "creates a vote" do
        sign_in Fabricate(:user)
        project = Fabricate(:project)
        expect{post :vote, id: project.id, vote: true}.to change(Vote, :count).by(1)
      end
      it "sets the flash success message" do
        sign_in Fabricate(:user)
        project = Fabricate(:project)
        post :vote, id: project.id, vote: true
        expect(flash[:notice]).to be_present
      end
    end
  end
  describe "POST unvote" do
  end
end