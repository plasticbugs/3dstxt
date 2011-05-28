class UsersController < ApplicationController
  before_filter :authenticate, :only => [:show, :edit]
  before_filter :correct_user, :only => [:show, :edit]

  def new
    @user = User.new
    @title = "Sign Up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:notice] = "Thanks for creating an account!"
      redirect_to :action => 'show', :id => @user  
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @messages = @user.messages
    @message = @user.messages.new
    @title = @user.name
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Your password was successfully changed!'
      redirect_to :action => 'show'
    else
      render :action => 'edit'
    end
  end
  
  private
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
  
  
end
