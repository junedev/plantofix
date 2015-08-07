class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.column :name, :string, limit: 1000
      t.integer :list_id
      t.integer :assignee_id

      t.timestamps null: false
    end
  end
end
