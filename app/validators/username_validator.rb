class UsernameValidator < ActiveModel::Validator
  def validate(record)
    unless record.username.match?('^[\S]+$')
      record.errors[:username] << "cannot contain spaces"
    end
  end
end
