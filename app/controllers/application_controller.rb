class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :data_for_menu
  def data_for_menu
  	@menu_categories = MenuCategory.all
  end 
  
end
