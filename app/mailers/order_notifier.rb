class OrderNotifier < ActionMailer::Base
  default from: "cesar.conopoima@gmail.com"

  def received(order,user)
  	@order 	= order
  	@user 	= user
  	email = order.email
  	mail(to: "cesar.conopoima@gmail.com", subject: "Order confirmation")
  end
end
