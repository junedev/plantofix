class Board < ActiveRecord::Base
  belongs_to :team
  has_many :users, through: :team
  validates :name, length: {in: 1..40}
  validates :team_id, numericality: {only_integer: true}
end
