class User < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :boards, through: :teams
  has_secure_password
  validates :username, uniqueness: true, length: {in: 6..30}
  validates :password, length: {in: 4..30} #FIXME increase for production
  validates :email, length: {in: 4..50}
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end
