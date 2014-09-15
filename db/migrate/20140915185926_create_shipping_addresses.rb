class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.text :address
      t.string :pin
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
