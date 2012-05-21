require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let (:user) {FactoryGirl.create(:user, :password_reset_token => "something")}
    let(:mail) { UserMailer.password_reset(user) }
    
    

    it "renders the headers" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(APP_CONFIG['gmail_from_address_for_password_reset_and_email_alerts'])
    end

    it "renders the body" do
      mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
    end
  end

end
