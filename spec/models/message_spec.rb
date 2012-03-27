require 'spec_helper'

describe Message do
  
  it 'should make a message from the Factory ' do
    f = FactoryGirl.create(:message)
    f.should_not be_nil
    f.should be_kind_of(Message)
    
  end
  
  it 'should generate a random 5 character pick up code' do
    m = Message.create(:contents => 'This is some sample text.')
    m.pickUpCode.should_not be_nil
    m.pickUpCode.length.should == 5
  end
  
  
  it 'should regenerate a new five digit key if the pick up code is not unique' do
    x = FactoryGirl.create(:message)
    x.save
    y = Message.create(:pickUpCode => 'scott', :contents => "This is some random text")
    y.save!
    y.pickUpCode.should_not == x.pickUpCode
    y.pickUpCode.length.should == 5
    
  end

    
  
  it 'should not be blank' do
    x = Message.create(:contents => "", :pickUpCode => "X"*5)
    
    x.should_not be_valid
  end
  
  it 'should not be longer than 5000 characters' do
    x = Message.create(:contents => "abcde"*1001, :pickUpCode => "X"*5)
    
    x.should_not be_valid
  end

  
  it 'should allow me to change the pickUpCode if a password has been entered' do
    x = FactoryGirl.create(:message)
    
    x.pickUpCode = "scott"
    x.save
    x.pickUpCode.should == "scott"
  end
  
  it 'should not allow me to create a pickUpCode that is in use' do
    x = FactoryGirl.create(:message)
    
    x.pickUpCode = 'scott'
    x.save
    
    y = Message.new(:contents => "23423523", :pickUpCode => "scott")
    y.save
    y.pickUpCode.should_not == x.pickUpCode
  end
  
  it 'should have a pickup code of at least three characters' do
    x = FactoryGirl.create(:message)
    
    x.pickUpCode = "sc"
    x.save
    
    x.should_not be_valid
  end
  
  it 'should not allow me to create a blank pick up code' do
    x = Message.create(:pickUpCode => "", :contents => "this is something")
    
    x.pickUpCode.should_not be_blank
  end
  
end
