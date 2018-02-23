class AddUserRefToProductCarts < ActiveRecord::Migration[5.1]
  def change
    add_reference :product_carts, :user, foreign_key: true
  end
end
