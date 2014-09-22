class TrackController < ApplicationController
  def index
  end

  def show
  	order = Order.where(:email => params[:email], :id => params[:order_number]).first
  	if order.blank?
  		flash[:error] = 'No order(s) found'
  		redirect_to action: 'index'
  	else
  		flash[:success] = "Current order status is #{order.order_status.capitalize}"
  		redirect_to :controller => :orders, :action => :show, :id => order.id 
  	end
  	
  end
end
