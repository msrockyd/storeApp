class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :manufacturer
      t.integer :menu_category_id
      t.integer :category_id
      t.integer :sub_category_id
      t.text :description
      t.attachment :image

      t.timestamps
    end
  end
end
