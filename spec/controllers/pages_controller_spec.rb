require 'spec_helper'

describe PagesController do
  describe "GET home" do
    it "sets @project" do
      get :home
      expect(assigns(:project)).to be_a_new Project
    end
    it "sets @projects" do
      50.times { Fabricate(:project) }
      get :home
      expect(assigns(:projects).length).to eq(25)
    end
  end
end