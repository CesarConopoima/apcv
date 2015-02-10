class OrderNotifier < ActionMailer::Base
  default from: "cesar.conopoima@gmail.com"

  def received(order,user)
  	@order 	= order
  	@user 	= user
  	email = order.email
  	mail(to: email, subject: "Order confirmation")
  end
  def paymentinformation(order,user)
  	@order 	= order
  	@user 	= user
  	email = order.email
  	mail(to: email, subject: "Payment information received")
  	#here should goes another mail to admin to procced payment information
  end
end
