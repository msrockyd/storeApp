class DashboardController < ApplicationController
	before_filter :check_admin
  def index
  	@users = User.where("is_admin = ? and sign_in_count <= ?", false, 10) 
  	@orders = Order.all
  end

  
end
