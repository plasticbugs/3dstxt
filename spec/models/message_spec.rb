require 'spec_helper'

describe Message do
  
  it 'should make a message from the Factory ' do
    f = Factory(:message)
    f.should_not be_nil
    f.should be_kind_of(Message)
    
  end
  
  it 'should generate a random 5 character pick up code' do
    m = Message.create(:contents => 'This is some sample text.')
    m.pickUpCode.should_not be_nil
    m.pickUpCode.length.should == 5
  end
  
  
  it 'should regenerate a new five digit key if the pick up code is not unique' do
    x = Message.create(:contents => "this is some sample text", :pickUpCode => "X"*5)
    y = Message.create(:contents => "this is some sample text", :pickUpCode => "X"*5)
    
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
  
  it 'should allow me to enter a password' do
    x = Factory(:message)
    
    x.password.should_not be_nil
  end
  
  it 'should allow me to change the pickUpCode if a password has been entered' do
    x = Factory(:message)
    
    x.pickUpCode = "scott"
    x.save
    x.pickUpCode.should == "scott"
  end
  
  it 'should not allow me to create a pickUpCode that is in use' do
    x = Factory(:message)
    
    x.pickUpCode = 'scott'
    x.save
    
    y = Message.create(:contents => "23423523", :pickUpCode => "scott", :password => "padss")
    y.should_not be_valid
  end
  
  
  
end
