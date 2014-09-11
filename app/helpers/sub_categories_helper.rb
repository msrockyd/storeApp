module SubCategoriesHelper
	def show_category_text(id)
		category =  Category.find(id)
		return category.category_name
	end
end
