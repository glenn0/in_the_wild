class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    @project = Project.new
    @all_projects = Project.all
  end
  
  def inside
  end 
    
end
