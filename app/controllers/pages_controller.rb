class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    @project = Project.new
    @curren
  end
  
  def inside
  end 
    
end
