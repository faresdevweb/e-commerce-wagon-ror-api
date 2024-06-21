class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :article

  validates :quantity, numericality: { greater_than: 0 }
end
