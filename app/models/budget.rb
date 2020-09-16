class Budget < ApplicationRecord
  validates :name, presence: true
  before_validation :normalize_name, on: [ :create, :update ]
  include ActiveModel::Validations
  validates_with UniqueBudgetValidator
  validates :amount, numericality: true
  belongs_to :user
  has_many :purchases
  has_many :cards, through: :purchases
  scope :current_budgets, -> {where(month: Date.today.strftime("%B '%y"))}

  def current_budget_months
    year = Date.today.strftime(" '%y")
    months = ['January','February','March','April','May','June','July','August','September','October','November','December']
    months.map{|m| m << year}
  end

  private
  def normalize_name
    self.name = name.downcase.titleize
  end

end
