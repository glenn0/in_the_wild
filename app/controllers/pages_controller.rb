class PagesController < ApplicationController

  def home
    @project = Project.new
    @all_projects = Project.all
  end
    
end
