class List < ActiveRecord::Base
  belongs_to :board
  has_many :tasks, dependent: :destroy
  validates :name, length: {in: 1..40}
  validates :board_id, numericality: {only_integer: true}

  def sorted_tasks
    self.tasks.sort_by{|task| task.position }
  end
end
