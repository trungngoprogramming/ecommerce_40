class Cart < ApplicationRecord
  has_many :product_carts, dependent: :destroy
end
