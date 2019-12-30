# require 'bcrypt'

class User < ActiveRecord::Base
  include ActiveModel::Validations
  # include BCrypt

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  has_secure_password
end
