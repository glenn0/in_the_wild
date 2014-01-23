class ProjectTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :project
end