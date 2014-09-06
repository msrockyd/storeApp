class CreateMenuCategories < ActiveRecord::Migration
  def change
    create_table :menu_categories do |t|
      t.string :menu_text

      t.timestamps
    end
  end
end
