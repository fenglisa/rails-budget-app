class Budget < ApplicationRecord
  validates :name, presence: true
  validates :amount, numericality: true

  before_validation :normalize_name

  belongs_to :user
  has_many :purchases
  has_many :cards, through: :purchases
  scope :current_budgets, -> {where(month: Date.today.strftime("%B '%y"))}

  def current_budget_months
    year = Date.today.strftime(" '%y")
    months = ['January','February','March','April','May','June','July','August','September','October','November','December']
    months.map{|m| m << year}
  end

  def unique_budget?(user,params)
    budget_names = []
    user.budgets.current_budgets.each do |b|
      budget_names << b.name
    end
    if budget_names.include?((params[:name]).capitalize)
      false
    else
      true
    end
  end

  private
  def normalize_name
    self.name = name.downcase.titleize
  end


end
