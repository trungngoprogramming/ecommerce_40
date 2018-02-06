class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.integer :quantity
      t.float :discount
      t.float :total_price
      t.integer :total_type_size
      t.float :total_weight
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
