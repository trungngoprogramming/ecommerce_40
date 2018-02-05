class Cart < ApplicationRecord
  has_many :products, dependent: :destroy
end
