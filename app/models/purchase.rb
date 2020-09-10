class Purchase < ApplicationRecord
  validates :amount, numericality: true
  validates :date, presence: true
  belongs_to :budget
  belongs_to :card

  def purchases_by_date
    current_user.purchases.sort_by do |p|
      p.date
    end
  end
end
