class UniqueBudgetValidator < ActiveModel::Validator
  def validate(record)
    budgets = Budget.all
    budgets.each do |b|
      if record.name == b.name && record.month == b.month
        record.errors[:this_budget] << "already exists"
      end
    end
  end
end
