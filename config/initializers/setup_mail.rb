ActionMailer::Base.smtp_settings = 
{
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => APP_CONFIG['gmail_from_address_for_password_reset_and_email_alerts'],
  :password             => APP_CONFIG['gmail_from_address_password'],
  :authentication       => 'plain',
  :enable_starttls_auto => true 
  }
  
ActionMailer::Base.default_url_options[:host] = "3dstxt.com"