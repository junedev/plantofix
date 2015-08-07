class Board < ActiveRecord::Base
  belongs_to :team
  has_many :users, through: :team
  has_many :lists, dependent: :destroy
  validates :name, length: {in: 1..40}
  validates :team_id, numericality: {only_integer: true}

  def is_private_board?
    if self.team.users.count == 1
      true
    else
      false
    end
  end

end
