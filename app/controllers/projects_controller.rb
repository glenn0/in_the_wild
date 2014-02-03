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
    @project = Project.find(params[:id])
    Vote.create(voteable: @project, creator: current_user, vote: params[:vote])
    flash[:notice] = "Thanks for voting."
    redirect_to home_path
  end

  def unvote
    @project = Project.find(params[:id])
    @vote = Vote.where(voteable: @project, creator: current_user, vote: true).first
    @vote.update_attributes(vote: false)
    flash[:notice] = "Your vote has been removed."
    redirect_to home_path
  end

  private

  def project_params
    params.require(:project).permit(:url)
  end
end