class PromotionMailer < ActionMailer::Base
  default from: "cesar.conopoima@gmail.com"
  
  def promotion(imgs)
  	#normally products should come as string to make db call smt like 
  	#beware to send mail only to users that has accepted to receive it
  	attachments.inline['image.jpg'] = File.read(imgs)
  	
  	mail(to: "cesar.conopoima@gmail.com", subject: "This are promotions from this month, #{products}")
  end
end
