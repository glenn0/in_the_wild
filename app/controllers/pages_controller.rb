class PagesController < ApplicationController

  def home
    @project = Project.new
    @projects = Project.order("created_at desc").page(params[:page])
  end
    
end