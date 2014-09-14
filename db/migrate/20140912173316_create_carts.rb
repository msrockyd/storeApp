class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :ip_address
      t.integer :user_id
      t.float :total_price
      t.integer :order_id

      t.timestamps
    end
  end
end
