class Product < ApplicationRecord
  belongs_to :product_group, dependent: :destroy
  belongs_to :cart
  has_many :comments, dependent: :destroy
end
