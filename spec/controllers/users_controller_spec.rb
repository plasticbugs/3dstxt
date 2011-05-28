require 'spec_helper'
include SessionsHelper

describe UsersController do
  render_views
  
  describe "GET 'show'" do
    
    # before(:each) do
    #      @attr = { :name => "Scott Moschella", :email => "scottmosch@gmail.com", :password => "foobar", :password_confirmation => "foobar"}
    #    end
    #    
    #    it "should be successful" do
    #      @user = User.create(@attr)
    #      sign_in @user
    #      get :show, :id => @user
    #      response.should be_success
    #    end
    #    
    #    it "should find the right user" do
    #      @user = User.new(@attr)
    #      @user.save
    #      get :show, :id => @user
    #      assigns(:user).should == @user
    #    end
  end
  
  
  describe "GET 'new'" do
    
    it "should be successful" do
      get :new
      response.should be_success
    end
    
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => ""}
      end
      
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
#      it "should have the right title" do
#        post :create, :user => @attr
#        response.should have_selector("title", :content => "Sign up")
#      end
      
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :name => "Scott Moschella", :email => "scottmosch@gmail.com", :password => "foobar", :password_confirmation => "foobar"}
      end
      
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:notice].should =~ /Thanks for creating an account!/i
      end
      
    end
    
  end
end