class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :name
      t.integer :list_id
      t.integer :assignee_id

      t.timestamps null: false
    end
  end
end
