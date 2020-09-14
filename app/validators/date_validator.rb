class DateValidator < ActiveModel::Validator
  def validate(record)
    if record.date > Date.today
      record.errors[:date] << "cannot be in the future"
    elsif record.date.month < Date.today.month
      record.errors[:date] << "should be in current month"
    end
  end
end
