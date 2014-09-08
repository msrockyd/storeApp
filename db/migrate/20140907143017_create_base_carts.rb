class CreateBaseCarts < ActiveRecord::Migration
  def change
    create_table :base_carts do |t|
      t.string :ip
      t.integer :product_id
      t.integer :quantity 	
      t.integer :user_id

      t.timestamps
    end
  end
end
