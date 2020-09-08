class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  include ActiveModel::Validations
  validates_with UsernameValidator

  
end