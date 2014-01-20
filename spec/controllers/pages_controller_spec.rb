require 'spec_helper'

describe PagesController do
  describe "GET home" do
    it "sets @project" do
      get :home
      expect(assigns(:project)).to be_a_new Project
    end
    it "sets @all_projects" do
      get :home
      expect(assigns(:all_projects)).to eq(Project.all)
    end
  end
end