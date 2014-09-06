class AddSizeAndFeatureListAndStockToProduct < ActiveRecord::Migration
  def change
    add_column :products, :size, :string
    add_column :products, :feature_list, :text
    add_column :products, :stock, :integer
  end
end
