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
  
  
  it 'should regenerate a new key if the pick up code is not unique' do
    x = Message.create(:contents => "this is some sample text", :pickUpCode => "X"*5)
    y = Message.create(:contents => "this is some sample text", :pickUpCode => "X"*5)
    
    y.pickUpCode.should_not == x.pickUpCode
    
  end
  
  it 'should create a new message and load' do
  end
  
end
