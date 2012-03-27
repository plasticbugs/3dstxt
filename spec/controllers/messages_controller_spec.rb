require 'spec_helper'

describe MessagesController do

  describe "GET 'index'" do

  end

  describe "GET 'show'" do
  
  end

  describe "GET 'new'" do
   
  end

  describe "GET 'edit'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      test_sign_in @user
      @message = FactoryGirl.create(:message)   
    end
    
    describe "success" do
      it "should allow me to edit one of my messages if I'm signed in" do
        get :edit, :pickUpCode => 'scott'
        response.status.should eql 200
      end
    end
    
    describe "failure" do
      it "should not allow me to edit someone else's message" do
        @message = Message.new(:contents => 'Whaddup?', :pickUpCode => 'test2', :user_id => 3)
        @message.save
        get :edit, :pickUpCode => 'test2'
        response.status.should eql 302
      end
    end
    
  end

end
