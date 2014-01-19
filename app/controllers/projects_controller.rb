class ProjectsController < ApplicationController
  def create
    @user = current_user
    @project = @user.projects.create(project_params)
    if @project.save
      flash[:notice] = "Thanks for submitting!"
      redirect_to home_path
    else
      redirect_to home_path
    end
  end

  private

  def project_params
    params.require(:project).permit(:url)
  end
end