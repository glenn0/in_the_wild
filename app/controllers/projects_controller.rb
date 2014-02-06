class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @project = Project.new(project_params)
    fetcher = Github::RepoFetcher.new(@project, current_user)
    repo = fetcher.retrieve
    if repo.success?
      flash[:notice] = "Thanks for contributing!"
    else
      flash[:error] = repo.message
    end
    redirect_to home_path
  end

  def vote
    find_project_and_vote
    if @vote.present?
      @vote.update_attributes(vote: @value)
    else
      @vote = Vote.create(voteable: @project, creator: current_user, vote: true)
    end

    respond_to do |format|
      format.html do
        if @vote.valid? && @vote.vote == true
          flash[:notice] = "You just dropped a star on #{@project.repo_name}."
        elsif @vote.valid? && @vote.vote == false
          flash[:notice] = "No star for you, #{@project.repo_name}."
        else
          flash[:error] = "Um, something's wrong. Tweet me the details @glenn0."
        end
        redirect_to :back
      end
      format.js
    end
  end

  private

  def project_params
    params.require(:project).permit(:url)
  end

  def find_project_and_vote
    @project = Project.find(params[:id])
    @vote = Vote.where(voteable: @project, creator: current_user).first
    @value = params[:vote]
  end
end