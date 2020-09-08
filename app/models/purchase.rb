class Purchase < ApplicationRecord
  belongs_to :budget
  belongs_to :card
end
