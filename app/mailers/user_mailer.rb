class UserMailer < ActionMailer::Base
  default :from => "3dstxt@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => "Password Reset")
  end
  
  def comment_alert(comment)
    @comment = comment
    mail(:to => comment.message.user.email, :subject => "You have a new comment on your 3dstxt.com page")
  end
  
end
