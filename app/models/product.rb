class Product < ApplicationRecord
  belongs_to :product_group, dependent: :destroy, optional: true
  has_many :products_carts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
