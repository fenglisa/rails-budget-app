class Budget < ApplicationRecord
  validates :name, presence: true
  validates :amount, numericality: true
  belongs_to :user
  has_many :purchases
  has_many :cards, through: :purchases

  def current_budget_months
    year = Date.today.strftime(" '%y")
    months = ['January','February','March','April','May','June','July','August','September','October','November','December']
    months.each{|m| m << year}
  end

  def current_budgets
    current_user.budgets.map{|b| b.name if b.month.include?(Date.today.strftime("%B '%y"))}
  end

end
