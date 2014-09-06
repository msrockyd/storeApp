class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category_name
      t.integer :menu_category_id

      t.timestamps
    end
  end
end
