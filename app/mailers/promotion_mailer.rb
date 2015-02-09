class PromotionMailer < ActionMailer::Base
  default from: "cesar.conopoima@gmail.com"
  
  def promotion(imgs)
  	#normally products should come as string to make db call smt like 
  	#beware to send mail only to users that has accepted to receive it
  	@rootURL = URI(root_url).to_s
  	# attachments.inline['image.jpg'] = File.read(@rootURL+"/"+imgs)

  	mail(to: "cesar.conopoima@gmail.com", subject: "This are promotions from this month")
  end
end
