module BenefitsHelper
  def new_budget_category
    budget_names = []
    current_user.budgets.each {|b| budget_names << b.name}
    if params[:benefit][:category] != "Other" && !budget_names.include?(params[:benefit][:category])
      current_user.budgets.build(name: params[:benefit][:category], amount: 0, month: Date.today.strftime('%B')).save
    end
  end

end
