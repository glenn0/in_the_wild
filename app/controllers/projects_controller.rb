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

  private

  def project_params
    params.require(:project).permit(:url)
  end
end