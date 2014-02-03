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
      @vote.update_attributes(vote: true)
      flash[:notice] = "You re-starred #{@project.repo_name}!"
    else
      new_vote = Vote.create(voteable: @project, creator: current_user, vote: true)
      if new_vote.valid?
        flash[:notice] = "You starred #{@project.repo_name}!"
      else
        flash[:error] = "Looks like you've already starred this one."
      end
    end
    redirect_to home_path
  end

  def unvote
    find_project_and_vote
    if @vote.present?
      @vote.update_attributes(vote: false)
      flash[:warning] = "Your star for #{@project.repo_name} has been removed."
    end
    redirect_to home_path
  end

  private

  def project_params
    params.require(:project).permit(:url)
  end

  def find_project_and_vote
    @project = Project.find(params[:id])
    @vote = Vote.where(voteable: @project, creator: current_user).first
  end
end