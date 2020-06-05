require 'bcrypt'

# Schema: User(user_name:string, password_digest:string, email:string)

class User < ApplicationRecord
  has_secure_password

  validates :user_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: {minimum: 6}
end
