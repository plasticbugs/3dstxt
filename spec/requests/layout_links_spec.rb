require 'spec_helper'

describe "LayoutLinks" do
  
  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      page.should have_selector("a", :href => signin_path, :content => "Sign in")
    end
  end
  
  describe "when signed in" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
      visit signin_path
      fill_in "session_email", :with => @user.email
      fill_in "session_password", :with => @user.password
      click_button "Sign in"
    end
    
    it "should have a signout link" do
      visit root_path
      page.should have_selector("a", :href => signout_path, :content => "Sign out")
    end
    
    it "should have a profile link"
  end
  
end
