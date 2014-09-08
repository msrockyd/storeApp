class CartsController < ApplicationController
  # @product_ids =""
  def send_products_id
  	remote_ip = request.remote_ip
  	product_id = params[:product_id]

  	base_cart  = BaseCart.where(:ip => remote_ip, :product_id => product_id ).first
  	if base_cart.blank?
  		BaseCart.create(:ip => remote_ip, :product_id => product_id, :quantity => 1 )
  	else
  		quantity = base_cart.quantity
  		base_cart.update(:quantity => (quantity+1))
	end
	redirect_to action: 'index'
  end

  def index
  	@products = Product.joins(:base_carts)
  end

  def update_base_cart_products_quantiy
  	cart = BaseCart.find(params["cart_id"])
  	cart.update(:quantity => params["quantity"])
  	render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end
