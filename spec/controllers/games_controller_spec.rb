require 'spec_helper'

describe GamesController do
  render_views
  before(:each) do
    @user = Factory(:user)
    test_sign_in @user
  end

 describe "GET 'search'" do
   it "returns http success" do
     get :search, :id => @user
     response.should be_success
   end
 end

 describe "POST 'search'" do
   it "returns http success" do
     game = Factory(:game)

     post :search, :id => game.id
     response.should be_success
     flash[:notice].should =~ /game was successfully/i
   end
   
   describe "failure" do
   #it "does not create a valid game" do
   #  test_sign_out @user
   #   game = Factory(:game)
   #   post :create, :id => game.id
   #   flash[:notice].should =~ /error adding that game/i
   # end
    end
 end

 describe "GET 'show'" do
   it "returns http success" do
   # get 'show', :id => @user
   # response.should be_success
   end
 end

 describe "GET 'update'" do
   it "returns http success" do
   # get 'update', :id => @user
   # response.should be_success
   end
 end

 describe "GET 'edit'" do
   it "returns http success" do
   # get 'edit', :id => @user
   # response.should be_success
   end
 end

 describe "GET 'destroy'" do
   it "returns http success" do
     @game = Factory(:game)
     @game.save!
     get 'destroy', :id => @game.id
     Game.count.should eql 0
   end
 end

end
