class OrderNotifier < ActionMailer::Base
  default from: "cesar.conopoima@gmail.com"

  def received(order,user)
  	@order 	= order
  	@user 	= user
  	email = order.email
  	mail(to: email, subject: 'Order confirmation')
  end
end
