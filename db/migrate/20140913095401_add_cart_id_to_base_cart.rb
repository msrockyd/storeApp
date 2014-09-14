class AddCartIdToBaseCart < ActiveRecord::Migration
  def change
    add_column :base_carts, :cart_id, :integer
  end
end
