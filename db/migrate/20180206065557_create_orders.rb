class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :address_ship
      t.integer :order_number
      t.boolean :paid
      t.datetime :paid_date
      t.datetime :date_ship
      t.datetime :date_of_receipt
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
