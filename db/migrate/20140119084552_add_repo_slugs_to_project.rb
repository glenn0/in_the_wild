class AddRepoSlugsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :repo_owner, :string
    add_column :projects, :repo_name, :string
  end
end
