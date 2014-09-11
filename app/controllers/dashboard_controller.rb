class DashboardController < ApplicationController
	before_filter :check_admin
  def index
  	@users = User.all
  	@admin_users  = AdminUser.find_by_sql("select users.email, admin_users.* from users, admin_users where admin_users.user_id = users.id and users.is_admin=true")
  end

  
end
