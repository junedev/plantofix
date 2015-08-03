class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :boards
  validates :name, length: {in: 1..40}
  
  def self.find_private_team(user)
    user.teams.each do |team|
      return team if (team.name == "Private board") && (team.users.count==1)
      # FIXME make "private board" string a constant in the app
    end
  end
end
