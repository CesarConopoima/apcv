Recaptcha.configure do |config|
   # config.public_key  = '6LfobQATAAAAAK5MSRwagq5H6nMYfjWQcyHyV1Bb'
   # config.private_key = '6LfobQATAAAAA'

  config.private_key = ENV['GOOGLE_SECRET_KEY']
  config.public_key  = ENV['GOOGLE_SITE_KEY_1']
  
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
  # Uncomment if you want to use the newer version of the API,
  # only works for versions >= 0.3.7:
  # config.api_version = 'v2'
end