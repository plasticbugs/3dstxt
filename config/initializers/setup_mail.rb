ActionMailer::Base.smtp_settings = 
{
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => GMAIL_FROM_ADDRESS,
  :password             => GMAIL_PASSWORD,
  :authentication       => 'plain',
  :enable_starttls_auto => true 
  }
  
ActionMailer::Base.default_url_options[:host] = "3dstxt.com"