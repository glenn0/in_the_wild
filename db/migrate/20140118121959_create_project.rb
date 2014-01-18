class CreateProject < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :url, :name
      t.text :description
      t.timestamps
    end
  end
end
