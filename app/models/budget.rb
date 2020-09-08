class Budget < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_many :cards, through: :purchases
end
