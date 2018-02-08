class Product < ApplicationRecord
  belongs_to :product_group, dependent: :destroy, optional: true
  belongs_to :cart, optional: true
  has_many :comments, dependent: :destroy
end
