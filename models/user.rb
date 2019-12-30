class User < ActiveRecord::Base
  include ActiveModel::Validations

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
