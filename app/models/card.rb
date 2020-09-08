class Card < ApplicationRecord
  validates :last_digits, numericality: true, length: { is: 4 }
  belongs_to :user
  has_many :purchases
  has_many :benefits
  has_many :budgets, through: :purchases
end
