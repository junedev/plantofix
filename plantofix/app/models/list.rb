class List < ActiveRecord::Base
  belongs_to :board
  has_many :tasks
  validates :name, length: {in: 1..40}
  validates :board_id, numericality: {only_integer: true}
end
