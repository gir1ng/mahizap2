class MealRecord < ApplicationRecord
  belongs_to :user
  validates :meal_content, presence: true
end
