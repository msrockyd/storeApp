class CartsController < ApplicationController
  # @product_ids =""
  def send_products_id
  	remote_ip = request.remote_ip
  	product_id = params[:product_id]
    if user_signed_in?
      user_id = current_user.id
    else
      user_id =""
    end

  	base_cart  = BaseCart.where(:ip => remote_ip, :product_id => product_id, :cart_id => nil ).first
  	if base_cart.blank?
  		BaseCart.create(:ip => remote_ip, :product_id => product_id, :quantity => 1, :user_id => user_id )
  	else
  		quantity = base_cart.quantity
  		base_cart.update(:quantity => (quantity+1))
	end
	redirect_to action: 'index'
  end

  def index
   if user_signed_in?
    @products =  Product.joins(:base_carts).where("(base_carts.cart_id is null or base_carts.order_id is null) and base_carts.user_id =#{current_user.id}")
   else
    @products =  Product.joins(:base_carts).where("(base_carts.cart_id is null or base_carts.order_id is null) and base_carts.ip ='#{request.remote_ip}'")
   end 

  end

  def update_base_cart_products_quantiy
  	cart = BaseCart.find(params["cart_id"])
  	cart.update(:quantity => params["quantity"])
  	render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end
