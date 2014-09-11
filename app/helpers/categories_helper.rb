module CategoriesHelper
	def show_menu_category_text(id)
		menu_category =  MenuCategory.find(id)
		return menu_category.menu_text
	end
end
