module OrdersHelper
	def get_product_detail(id)
		return Product.find(id)
	end
end
