class AddProductNameToCarts < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :product_name, :string
  end
end
