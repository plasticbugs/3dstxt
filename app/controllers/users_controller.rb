class UsersController < ApplicationController
  before_filter :authenticate, :only => [:show, :edit, :change_password]
  before_filter :correct_user, :only => [:show, :edit, :change_password]

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
  
  def change_password
    @user = User.find(params[:id])
    render :action => "change_password"
  end

  
  def show
    @user = User.find(params[:id])
    @messages = @user.messages
    @message = Message.new
    @title = @user.name
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Your settings have been saved'
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
