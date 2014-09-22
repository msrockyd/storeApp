class ProductMailer < ActionMailer::Base
  default from: "ijkonbusiness@gmail.com"

  def order_detail(email, order_detail)
  	@orders = order_detail
  	mail(to: email, subject: " Confirmed - Your Order is now being processed!")
  end

  def sign_up_mail(email)
  	mail(to: email, subject: "Welcome Message")
  end

end
