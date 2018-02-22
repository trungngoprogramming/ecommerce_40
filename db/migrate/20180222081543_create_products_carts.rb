class CreateProductsCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :products_carts do |t|
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
