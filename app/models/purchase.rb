class Purchase < ApplicationRecord
  validates :amount, numericality: true
  belongs_to :budget
  belongs_to :card
end
