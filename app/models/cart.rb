class Cart < ApplicationRecord
  has_many :products_carts, dependent: :destroy
end
