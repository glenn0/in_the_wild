class AddRepoDescriptionToProject < ActiveRecord::Migration
  def change
    add_column :projects, :repo_description, :text
  end
end
