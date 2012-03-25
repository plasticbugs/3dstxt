require 'spec_helper'

describe "Users" do
  
  describe "signup" do
    
    describe "failure" do
      
      it "should not make a new user" do
        lambda do
           visit signup_path
           #fill_in "user_name",         :with => ""
           fill_in "user_email",        :with => ""
           fill_in "user_password",     :with => ""
           fill_in "user_password_confirmation", :with => ""
           click_button "Sign up"
           current_path.should == '/users'
           page.should have_selector("div.alert")
         end.should_not change(User, :count)
      end
    end
    
    describe "signup" do
      
      it "should make a new user" do
        lambda do
          visit signup_path
          #fill_in "user_name", :with => "Scott Moschella"
          fill_in "user_email",        :with => "scottmosch@gmail.com"
          fill_in "user_password",     :with => "foobar"
          fill_in "user_password_confirmation", :with => "foobar"
          click_button "Sign up"
          page.should have_content("Thanks for creating an account!")
          current_path.should == "/users/1"
          #assert_template("users/1")
        end.should change(User, :count).by(1)
      end
    end
    
    
  end
  
      
  
  describe "GET /users/new" do
    it "works! (now write some real specs)" do
      get new_user_path
    end
  end
end
