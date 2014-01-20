class Project < ActiveRecord::Base
  has_many :submissions
  has_many :users, through: :submissions

  validates_presence_of :url
  #validates_presence_of :repo_owner
  #validates_presence_of :repo_name

  validates_format_of :url, with: /(http|https)\:\/\/(github.com)\/.*\/.*/
end