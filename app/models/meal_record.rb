class MealRecord < ApplicationRecord
  belongs_to :user
  validates :meal_content, presence: true
  validates :total_calorie, numericality: { only_integer: true }
  validates :total_sugar, numericality: { only_integer: true }
end
