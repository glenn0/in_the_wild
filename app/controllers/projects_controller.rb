class ProjectsController < ApplicationController
  def create
    project = Project.new(project_params)
    if project.save
      flash[:notice] = "Thanks for submitting!"
      redirect_to home_path
    else
      redirect_to home_path
    end
  end

  private

  def project_params
    params.require(:project).permit(:url, :user_id)
  end
end