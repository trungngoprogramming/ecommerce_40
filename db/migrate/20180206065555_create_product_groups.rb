class CreateProductGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :product_groups do |t|
      t.string :name
      t.text :content
      t.string :image
      t.integer :parent_id

      t.timestamps
    end
  end
end
