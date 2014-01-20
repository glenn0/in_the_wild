class AddRepoOwnerUrlToProject < ActiveRecord::Migration
  def change
    add_column :projects, :repo_owner_url, :string
  end
end
