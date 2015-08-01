class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  acts_as_followable
  acts_as_follower

  validates  :username, presence: true, length:{maximum: 50},  uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8}
  validates  :password_confirmation, presence: true

end
