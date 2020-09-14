class Purchase < ApplicationRecord
  validates :amount, numericality: true
  validates :date, presence: true
  include ActiveModel::Validations
  validates_with DateValidator
  belongs_to :budget
  belongs_to :card
  scope :by_most_recent_date, -> {order(date: :desc)}

end
