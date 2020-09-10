class Purchase < ApplicationRecord
  validates :amount, numericality: true
  validates :date, presence: true
  belongs_to :budget
  belongs_to :card
end
