class Article < ApplicationRecord
    belongs_to :category, optional: true
    has_many :reviews, dependent: :destroy
  end
  