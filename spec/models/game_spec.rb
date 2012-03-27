require 'spec_helper'

describe Game do
  it "should make a Game from the Factory" do
    u = FactoryGirl.create(:user)
    g = FactoryGirl.create(:game)

    g.should_not be_nil
    g.should be_kind_of(Game)
  end
  
  it "should not let me add the same game twice" do
    u = FactoryGirl.create(:user)
    g = FactoryGirl.create(:game)
    h = Game.new(:asin => "B0053BCO00", :user_id => 1)
    h.should_not be_valid
    puts h.errors
  end
  
end
