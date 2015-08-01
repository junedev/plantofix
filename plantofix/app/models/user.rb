class User < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :boards, through: :teams
  has_secure_password
end
