class CreateSuggestProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :suggest_products do |t|
      t.string :name
      t.integer :quantity
      t.integer :size
      t.float :weight
      t.string :color
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
