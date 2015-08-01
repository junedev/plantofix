class Board < ActiveRecord::Base
  belongs_to :team
  has_many :users, through: :team
end
