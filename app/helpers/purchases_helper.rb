module PurchasesHelper
  def purchase_total(parent)
    parent_purchases = []
    if parent == @card
      current_user.purchases.each do |p|
        parent_purchases << p.amount if p.card_id == parent.id
      end
    elsif parent == @budget
      current_user.purchases.each do |p|
        parent_purchases << p.amount if p.budget_id == parent.id
      end
    end
    parent_purchases.sum.round(2)
  end

  def purchases_by_date
    current_user.purchases.sort_by do |p|
      p.date
    end
  end
end
