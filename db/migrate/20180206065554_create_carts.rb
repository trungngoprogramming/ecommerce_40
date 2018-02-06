class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.float :price
      t.integer :quantity
      t.float :discount
      t.float :total_price

      t.timestamps
    end
  end
end
