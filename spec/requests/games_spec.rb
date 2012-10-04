require 'spec_helper'

describe "Games" do
		describe "add game" do

	before(:each) do
      @user = FactoryGirl.create(:user)
      visit signin_path
      fill_in "session_email", :with => @user.email
      fill_in "session_password", :with => @user.password
      click_button "Sign in"
  end

  it "should allow me to add a game" do
  	lambda do
		     visit "/users/#{@user.id}/games/search"
		     #fill_in "user_name",         :with => ""
		     fill_in "query",        :with => "New Super Mario Bros. 2"
		     click_button "Add Game"
		     current_path.should == "/users/#{@user.id}/games/search"
		     page.should have_selector("div.alert")
		   end.should change(Game, :count)
  	
  end

  it "should not add a game when an invalid game with no image is added" do
  	lambda do
		     visit "/users/#{@user.id}/games/search"
		     #fill_in "user_name",         :with => ""
		     fill_in "query",        :with => "Elite Beat Agents"
		     click_button "Add Game"
		     current_path.should == "/users/#{@user.id}/games/search"
		     page.should have_selector("div.alert")
		   end.should_not change(Game, :count)
  end
		
		


	end




end