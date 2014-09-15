class CartsController < ApplicationController
  # @product_ids =""
  def send_products_id
  	remote_ip = request.remote_ip
  	product_id = params[:product_id]
    if user_signed_in?
      user_id = current_user.id
      @base_cart  = BaseCart.where(:user_id => user_id, :product_id => product_id, :order_id => nil ).first
    else
      user_id =""
      @base_cart  = BaseCart.where(:ip => remote_ip, :product_id => product_id, :order_id => nil ).first
    end

  	if @base_cart.blank?
  		BaseCart.create(:ip => remote_ip, :product_id => product_id, :quantity => 1, :user_id => user_id )
  	else
  		quantity = @base_cart.quantity
      if Product.find(params[:product_id]).stock >= (quantity+1) 
  		  @base_cart.update(:quantity => (quantity+1))
      end
	  end
	redirect_to action: 'index'
  end

  def index
   if user_signed_in?
    p "============"
    @base_carts = Product.find_by_sql("select p.*,  b.*, b.id as id from products p, base_carts b where b.product_id = p.id and ((b.cart_id is null or b.order_id is null) and b.user_id =#{current_user.id}) ")  
    p @base_carts.count
    #Product.joins(:base_carts).where("(base_carts.cart_id is null or base_carts.order_id is null) and base_carts.user_id =#{current_user.id}")
   else
    @base_carts = Product.find_by_sql("select p.*,  b.*, b.id as id from products p, base_carts b where b.product_id = p.id and ((b.cart_id is null or b.order_id is null) and b.ip ='#{request.remote_ip}') and b.user_id is null ")  
    #Product.joins(:base_carts).where("(base_carts.cart_id is null or base_carts.order_id is null) and base_carts.ip ='#{request.remote_ip}' and user_id is null")
   end 

  end

  def update_base_cart_products_quantiy
  	cart = BaseCart.find(params["cart_id"])
  	cart.update(:quantity => params["quantity"])
  	render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def delete
    BaseCart.destroy(params[:id])
    redirect_to :action => :index
  end
end
