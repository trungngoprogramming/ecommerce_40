class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthday
      t.integer :gender
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.integer :phone
      t.string :company
      t.string :email
      t.string :password_digest
      t.integer :role, default: 1

      t.timestamps
    end
  end
end
