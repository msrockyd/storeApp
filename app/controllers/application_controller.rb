class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :data_for_menu
  
  def data_for_menu
    @menu_categories = MenuCategory.all
  end 


  def after_sign_in_path_for(resource)
   # if current_user.sign_in_count <= 1  #This will take the user to change his password after signed in for the first time.
   #  "users/edit"
   # else
   #  "/home"
   # end

   if current_user.is_admin?
   		"/dashboard/index"
   end

  end

  def check_admin
    if user_signed_in?
      unless current_user.is_admin
        redirect_to :controller => 'home', :action => 'index'
      end
    else
      redirect_to :controller => 'home', :action => 'index'
    end 
  end

  
end
