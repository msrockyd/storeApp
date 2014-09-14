class AddOrderIdToBaseCart < ActiveRecord::Migration
  def change
    add_column :base_carts, :order_id, :integer
  end
end
