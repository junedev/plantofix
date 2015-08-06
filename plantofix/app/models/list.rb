class List < ActiveRecord::Base
  @@counter = 100
  belongs_to :board
  has_many :tasks, dependent: :destroy
  validates :name, length: {in: 1..40}
  validates :board_id, numericality: {only_integer: true}

  def next_id
    @@counter += 1
  end

  def sorted_tasks
    puts "*"*50
    puts "*"*50
    puts "*"*50
    self.tasks.each do |i|
      puts i.position
    end
    puts "*"*50
    puts "*"*50
    puts "*"*50
    self.tasks.sort_by{|task| task.position }
  end
end
