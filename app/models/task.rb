class Task < ActiveRecord::Base
  belongs_to :list
  delegate :board, to: :list
  belongs_to :assignee, class_name: "User", foreign_key: "assignee_id"
  validates :name, length: {in: 1..999} 
  validates :list_id, numericality: {only_integer: true}
  validates :color, length: { maximum: 30 }
  validates :description, length: { maximum: 10000 }
end
