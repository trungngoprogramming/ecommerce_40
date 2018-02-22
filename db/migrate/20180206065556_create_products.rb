class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :size
      t.string :color
      t.float :discount
      t.text :description
      t.integer :quantity_product_available
      t.float :discount_customer_available
      t.integer :rate
      t.datetime :date_of_entry
      t.references :product_group, foreign_key: true

      t.timestamps
    end
  end
end
