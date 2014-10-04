class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    #@products =  Product.joins(:base_carts).where(:base_carts => {:order_id=> params[:id], :user_id => current_user.id})
    @base_carts = BaseCart.where(:order_id => params[:id])
    @ship_address = ShippingAddress.where(:order_id => params[:id]).first

  end

  # GET /orders/new
  def new
    @states = ["Andaman and Nicobar Islands","Andra Pradesh","Arunachal Pradesh","Assam","Bihar","Chandigarh",
        "Chhattisgarh","Daman and Diu","Delhi","Goa","Gujarat","Haryana","Himachal Pradesh",
        "Jammu and Kashmir","Jharkhand","Karnataka","Kerala","Lakshadeep","Madya Pradesh","Maharashtra",
        "Manipur","Meghalaya","Mizoram","Nagaland","Orissa","Pondicherry","Punjab","Rajasthan","Sikkim",
        "Tamil Nadu","Tripura","Uttaranchal","Uttar Pradesh","West Bengal"]
    @order = Order.new
    @total_price = Cart.find(params[:cart_id].to_i).total_price
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
      # raise params.inspect
    @order = Order.new(order_params)
    @order.ip_address = request.remote_ip
    # @order.last_name = params[]
    respond_to do |format|
      if @order.save_with_payment(current_user.id)
        ShippingAddress.create({:order_id => @order.id, :user_id => current_user.id, :first_name => params[:recipient][:first_name], :last_name => params[:recipient][:last_name], :phone_number => params[:recipient][:phone_number], :address => params[:recipient][:address], :pin => params[:recipient][:pin], :city => params[:recipient][:city], :state => params[:recipient][:state]})

        base_carts = BaseCart.where(:order_id => @order.id)
        product_stock_update(base_carts)

        ProductMailer.order_detail(current_user.email, @order).deliver # send order conf mail

        format.html { redirect_to @order, notice: 'Order was successfully processed.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end


    # PAYPAL INTEGRATION
    # if @order.save
    #   if @order.purchase
    #     render :action => "success"
    #   else
    #     render :action => "failure"
    #   end
    # else
    #   render :action => 'new'
    # end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def check_login
    product_price = 0
    params[:id].each do |id|
      base_cart = BaseCart.find(id)
      product = Product.find(base_cart.product_id)
      product_price += product.price * base_cart.quantity
    end
    # raise params.inspect
    if user_signed_in?
      cart = Cart.create({:ip_address => request.remote_ip, :total_price => product_price, :user_id => current_user.id})
      params[:id].each do |id|
        base_cart = BaseCart.find(id)
        base_cart.update({:cart_id => cart.id, :user_id => current_user.id})
      end
      redirect_to new_order_path(:cart_id => cart.id)
    else
      cart = Cart.create({:ip_address => request.remote_ip, :total_price => product_price})
      params[:id].each do |id|
        base_cart = BaseCart.find(id)
        base_cart.update({:cart_id => cart.id})
      end
      cookies[:last_url] = '/orders/new/?cart_id='+cart.id.to_s
      redirect_to new_user_session_path
      
    end  
    # raise params.inspect
  end

  def update_order_status
    # raise params.inspect
    order = Order.find(params["order_id"])
    order.update({:order_status => params[:status]})
    flash[:success] = "Order status for the order ID #{order.id} was successfully updated."
    redirect_to :action => :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:cart_id,:amount, :ip_address, :name, :last_name, :card_type, :card_expires_on, :card_number, :card_verification, :stripe_card_token, :email)
    end

    def product_stock_update(base_carts)
      base_carts.each do |base_cart|
        product =  Product.find(base_cart.product_id)
        new_quantity = product.stock.to_i - base_cart.quantity.to_i
        product.update({:stock => new_quantity })
      end
    end
end
