class Project < ActiveRecord::Base
  has_many :submissions
  has_many :users, through: :submissions

  has_many :project_tags
  has_many :tags, through: :project_tags

  validates_presence_of :url
  #validates_presence_of :repo_owner
  #validates_presence_of :repo_name

  validates_format_of :url, with: /(http|https)\:\/\/(github.com)\/.*\/.*/
end