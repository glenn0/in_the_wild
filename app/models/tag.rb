class Tag < ActiveRecord::Base
  has_many :project_tags
  has_many :projects, through: :project_tags

  validates_presence_of :name
end