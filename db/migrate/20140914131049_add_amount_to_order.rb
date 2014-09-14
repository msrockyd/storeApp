class AddAmountToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :amount, :float
    add_column :orders, :last_name, :string
  end
end
