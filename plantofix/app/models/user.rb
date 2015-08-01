class User < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :boards, through: :teams
  has_many :tasks, class_name: "Task", foreign_key: "assignee_id"
  has_secure_password
  validates :username, uniqueness: true, length: {in: 4..30}
  validates :password, length: {in: 4..30} #FIXME increase for production
  validates :email, uniqueness: true, length: {in: 4..50}
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end
