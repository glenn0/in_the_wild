require 'spec_helper'

describe ProjectsController do
  describe "#github_up?" do
    it "returns true when GitHub is available" do
      user = Fabricate(:user)
      project = Fabricate(:project)
      fetcher = Github::RepoFetcher.new(project, user)
      expect(fetcher.github_up?).to be_true
    end
  end
  describe "#fetch_repo_owner_and_name" do
    let(:run_this_method_with_objects) do
      user = Fabricate(:user)
      @project = Fabricate(:project, url: "https://github.com/glenn0/in_the_wild")
      fetcher = Github::RepoFetcher.new(@project, user)
      fetcher.fetch_repo_owner_and_name
    end
    it "retrieves repo owner name" do
      run_this_method_with_objects
      expect(@project.repo_owner).to eq("glenn0")
    end
    it "retrieves repo name" do
      run_this_method_with_objects
      expect(@project.repo_name).to eq("in_the_wild")
    end
    it "creates repo owner url attribute" do
      run_this_method_with_objects
      expect(@project.repo_owner_url).to eq("https://github.com/glenn0")      
    end
    it "creates repo url attribute" do
      run_this_method_with_objects
      expect(@project.repo_url).to eq("https://github.com/glenn0/in_the_wild")
    end
  end
  describe "#valid_repo?" do
    it "returns true if a valid GitHub repository" do
      user = Fabricate(:user)
      @project = Fabricate(:project, url: "https://github.com/glenn0/in_the_wild", repo_owner: "glenn0", repo_name: "in_the_wild")
      @fetcher = Github::RepoFetcher.new(@project, user)
      expect(@fetcher.valid_repo?).to be_true
    end
    it "returns false if not a valid GitHub repository" do
      user = Fabricate(:user)
      @project = Fabricate(:project, url: "https://github.com/glenn0/not_a_repo", repo_owner: "glenn0", repo_name: "not_a_repo")
      @fetcher = Github::RepoFetcher.new(@project, user)
      expect(@fetcher.valid_repo?).to be_false
    end
  end
  describe "#get_additional_repo_attributes" do
    it "retrieves repo owner avatar" do
      user = Fabricate(:user)
      project = Fabricate(:project, url: "https://github.com/glenn0/not_a_repo", repo_owner: "glenn0", repo_name: "in_the_wild")
      fetcher = Github::RepoFetcher.new(project, user)
      fetcher.get_additional_repo_attributes
      expect(project.repo_owner_avatar).to eq("bd3cad1521f294ba4531d3c9e0a15fe3")
    end
    it "retrieves repo description" do
      user = Fabricate(:user)
      project = Fabricate(:project, url: "https://github.com/glenn0/not_a_repo", repo_owner: "glenn0", repo_name: "in_the_wild")
      fetcher = Github::RepoFetcher.new(project, user)
      fetcher.get_additional_repo_attributes
      expect(project.repo_description).to eq("A web app for surfacing great code examples. Currently focused on RSpec.")
    end
  end
  describe "#generate_rspec_tags" do
    it "generates a new tag" do
      user = Fabricate(:user)
      project = Fabricate(:project, url: "https://github.com/glenn0/not_a_repo", repo_owner: "glenn0", repo_name: "in_the_wild")
      fetcher = Github::RepoFetcher.new(project, user)
      fetcher.generate_rspec_tags
      expect(Tag.where(name: "controllers").count).to eq(1)
    end
    it "associates a new tag with the project" do
      user = Fabricate(:user)
      project = Fabricate(:project, url: "https://github.com/glenn0/not_a_repo", repo_owner: "glenn0", repo_name: "in_the_wild")
      fetcher = Github::RepoFetcher.new(project, user)
      fetcher.generate_rspec_tags
      expect(Tag.where(name: "controllers").first.projects).to include(project)
    end
    it "doesn't create a new tag if an existing tag with the same name exists" do
      user = Fabricate(:user)
      project = Fabricate(:project, url: "https://github.com/glenn0/not_a_repo", repo_owner: "glenn0", repo_name: "in_the_wild")
      fetcher = Github::RepoFetcher.new(project, user)
      Tag.new(name: "controllers")
      fetcher.generate_rspec_tags
      expect(Tag.where(name: "controllers").count).to eq(1)
    end
    it "associates an existing tag with the project" do
      user = Fabricate(:user)
      project = Fabricate(:project, url: "https://github.com/glenn0/not_a_repo", repo_owner: "glenn0", repo_name: "in_the_wild")
      fetcher = Github::RepoFetcher.new(project, user)
      Tag.new(name: "controllers")
      fetcher.generate_rspec_tags
      expect(Tag.where(name: "controllers").first.projects).to include(project)
    end
  end
end