class PromotionMailer < ActionMailer::Base
  default from: "cesar.conopoima@gmail.com"
  
  def promotion(products)
  	#normally products should come as string to make db call smt like 
  	#products.split(",").each do |product|
  		#ProductObject = Product.find_by_code(product)
  		#pic = ProductObject.imageurl
  	#end
  	#beware to send mail only to users that has accepted to receive it
  	mail(to: "cesar.conopoima@gmail.com", subject: "This are promotions from this month, #{products}")
  end
end
