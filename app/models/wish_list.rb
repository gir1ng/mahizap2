class WishList < ApplicationRecord
  belongs_to :user
  validates :wish_content, presence: true
end
