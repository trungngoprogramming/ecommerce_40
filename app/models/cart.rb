class Cart < ApplicationRecord
  has_many :product_carts, dependent: :destroy

  def total_price
    price * quantity
  end
end
