class Category < ActiveRecord::Base
	belongs_to :menu_category
	has_many :sub_categories 
end
