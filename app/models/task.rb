class Task < ApplicationRecord
  belongs_to :user
  validate :input_one_field?

  private

  def input_one_field?
    if (todo.empty? && not_todo.empty?) || (todo.present? && not_todo.present?)
      errors.add(:base, "どちらか片方のみ入力してください")
    end
  end
end
