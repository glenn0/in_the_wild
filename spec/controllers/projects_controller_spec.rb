require 'spec_helper'

describe ProjectsController do
  describe "POST create" do
    context "with authenticated user" do
      context "with valid input" do
        let(:post_valid_inputs_with_user) do
          sign_in Fabricate(:user)
          post :create, project: Fabricate.attributes_for(:project)
        end
        
        it "creates a project" do
          post_valid_inputs_with_user
          expect(Project.count).to eq(1)
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
      end
    end
    context "with unauthenticated user" do
      let(:post_valid_inputs_no_user) { post :create, project: Fabricate.attributes_for(:project) }
    end
  end
end