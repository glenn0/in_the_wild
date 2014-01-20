class AddRepoOwnerAvatarToProject < ActiveRecord::Migration
  def change
    add_column :projects, :repo_owner_avatar, :string
  end
end
