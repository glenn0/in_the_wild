class AddCleanUrlToProject < ActiveRecord::Migration
  def change
    add_column :projects, :repo_url, :string
  end
end