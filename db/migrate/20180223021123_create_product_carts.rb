class CreateProductCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :product_carts do |t|
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
