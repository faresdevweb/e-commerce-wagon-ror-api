# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
end
