class AddOrderStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :order_status, :string, default: "Confirm"
  end
end
