class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def create
    fetch_repo_owner_and_name
    if valid_repo?
      @user = current_user
      @project = @user.projects.create(project_params)
      if @project.save
        flash[:notice] = "Thanks for submitting!"
        redirect_to home_path
      else
        flash[:error] = "Hmmm... that's not a URL I can understand at the moment."
        redirect_to home_path
      end
    else
      flash[:error] = "Hmmm... that's not a URL I can understand at the moment."
      redirect_to home_path
    end
  end

  private

  def project_params
    params.require(:project).permit(:url, :repo_owner, :repo_name, :repo_owner_url, :repo_url)
  end

  def fetch_repo_owner_and_name
    repo_from_url = Octokit::Repository.from_url(project_params[:url])
    @repo_meta = {
      repo_owner: repo_from_url.owner,
      repo_name: repo_from_url.name,
      repo_owner_url: "https://github.com/#{repo_from_url.owner}",
      repo_url: "https://github.com/#{repo_from_url.owner}/#{repo_from_url.name}" }
    params[:project].merge!(@repo_meta)
  end

  def valid_repo?
    Octokit.repository?("#{@repo_meta[:repo_owner]}/#{@repo_meta[:repo_name]}")
  end
end