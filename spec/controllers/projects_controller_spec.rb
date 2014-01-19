require 'spec_helper'

describe ProjectsController do
  describe "POST create" do
    context "with authenticated user" do
      let(:post_valid_inputs_with_user) do
        user = Fabricate(:user)
        set_current_user(user)
        post :create, project: Fabricate.attributes_for(:project), user_id: user.id
      end

      context "with valid input" do
        it "creates a project" do
          expect{post_valid_inputs_with_user}.to change(Project, :count).by(1)
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