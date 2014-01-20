class CreateSubmission < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :user_id, :project_id
    end
  end
end
