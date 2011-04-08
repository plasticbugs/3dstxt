require 'spec_helper'

describe User do
  before(:each) do
    @attr = {:name => "scottmosch",
             :email => "scottmosch@gmail.com",
             :password => "foobar",
             :password_confirmation => "foobar"}
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    longname = User.new(@attr.merge(:name => "a"*51 ))
    
    longname.should_not be_valid
  end
  
  it "should reject emails that are duplicates up to case" do
    user1 = User.create(@attr.merge(:email =>"scottmosch@gmail.com".upcase))
    user2 = User.new(@attr)
    
    user2.should_not be_valid
  end
  
  describe "password validations" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
      
      
    end
    
    
  end
  
  
end
