class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
