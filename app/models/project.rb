class Project < ActiveRecord::Base
  has_many :submissions
  has_many :users, through: :submissions

  validates_presence_of :url
end