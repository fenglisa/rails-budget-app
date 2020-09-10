class Budget < ApplicationRecord
  validates :name, presence: true
  validates :amount, numericality: true
  belongs_to :user
  has_many :purchases
  has_many :cards, through: :purchases

  def budget_cards
    @budget.cards.uniq
  end
end
