class AddPositionToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :position, :float
  end
end
