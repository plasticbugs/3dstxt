class UsersController < ApplicationController
  

  def new
    @user = User.new
    @title = "Sign Up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Thanks for creating an account!"
      redirect_to :action => 'show', :id => @user  
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  
  
end
