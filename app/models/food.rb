class Food < ApplicationRecord
  validates :food_name, presence: true
  validates :search_name, presence: true
  validates :quantifier, presence: true
  validates :calorie, numericality: { only_integer: true }
  validates :sugar, numericality: true
end
