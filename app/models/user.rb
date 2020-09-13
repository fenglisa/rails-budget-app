class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  include ActiveModel::Validations
  validates_with UsernameValidator
  has_many :cards
  has_many :purchases, through: :cards
  has_many :benefits, through: :cards
  has_many :budgets

  def self.find_or_create_with_oauth(auth)
    u = User.find_by_uid(auth['uid']) || User.find_or_create_by_username(auth)
    u.username = auth['info']['email']
    u.save
    u
  end

  def self.find_or_create_by_username(auth)
    User.find_or_create_by(username: auth['info']['email']) do |u|
      u.uid = auth['uid']
      u.password = SecureRandom.hex(20)
    end
  end
end
