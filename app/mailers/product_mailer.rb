class ProductMailer < ActionMailer::Base
  default from: "ms.rockyd@gmail.com"

  def order_detail(email, order_detail)
  	@orders = order_detail
  	mail(to: email, subject: " Confirmed - Your Order is now being processed!")
  end

end
