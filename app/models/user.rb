class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	         :recoverable, :rememberable, :trackable, :validatable
	after_create :congrats_email

	def congrats_email
	  ProductMailer.sign_up_mail(self.email).deliver
	end

end
