class ProductGroup < ApplicationRecord
  has_many :products, dependent: :destroy
end
