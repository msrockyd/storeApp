class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :sub_category_name
      t.integer :category_id

      t.timestamps
    end
  end
end
