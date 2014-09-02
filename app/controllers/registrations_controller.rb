class RegistrationsController < Devise::RegistrationsController
	private
	def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :signup_for_news_latter)
  end
end
