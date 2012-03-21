class MessagesController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :destroy]
  before_filter :correct_user, :only => [:edit, :destroy]
    
  def index
    redirect_to :root
    #@message = Message.search(params[:search])
  end

  def show
    @message = Message.find_by_pickUpCode(params[:pickUpCode].downcase)
    @comments = @message.comments.all
    @comment = Comment.new
    impressionist(@message)
      if !@message.user.friend_code.nil?
        @friendcode = format_friend_code(@message.user.friend_code)
      end
  end
  
  def format_friend_code(friend_code)
    friend_code.gsub(/\D/, '').gsub(/.{4}/, '\0 ')
  end

  def new
    if signed_in?
      @user = current_user
    end
   @message = Message.new
  end
  
  def edit
    @message = Message.find_by_pickUpCode(params[:pickUpCode].downcase)
  end
  
  def update
    @message = Message.find_by_pickUpCode(params[:pickUpCode].downcase)
    
    if @message.update_attributes(params[:message])
      flash[:notice] = 'Your 3DS txt message was successfully updated!'
      redirect_to :action => 'show', :pickUpCode => @message.pickUpCode
    else
      render :action => 'edit'
    end
  end

  
  
#  def validate
#    color = 'red'
#    pickUpCode = params[:pickUpCode]
#    
#      message = Message.find_by_pickUpCode(pickUpCode)      
#      if message.size > 0        
#        warning = 'Taken'     
#      else
#        message = 'Available'
#        color = 'green'
#      end
#  
#    @warning = "<b style='color:#{color}'>#{warning}</b>"
#    render :partial=>'warning'
#  end
  
  
  def create
    
    if signed_in? 
      @user = current_user
      @messages = @user.messages
      @message = Message.new
      @message.user_id = @user.id
      @message.contents(params[:message][:contents])
      @message.pickUpCode(params[:message][:pickUpCode])
      #@message = @user.messages.build(params[:message])
    else
      @message = Message.new(params[:message])
    end
        
    if @message.save
      flash[:notice] = 'Your page was created!'
      redirect_to :action => "show", :pickUpCode => @message.pickUpCode
    elsif @message.save && signed_in?
      render :action => 'users/show', :messages => current_user.messages
    elsif !@message.valid? && signed_in?
      # flash[:notice] = ":("
      # redirect_to root_path, {:flash => "!"}
      render :template => 'users/show'
    else
      
      flash[:error] = "Your message must be between 1 and 5000 characters"
      redirect_to root_url
    end
  end
    
    
 def destroy
    @user = current_user
   @message = Message.find(params[:id])
   @message.destroy
   flash[:notice] = "Message was successfully deleted."
   redirect_to user_path(current_user.id)
   
 end
 
 private
 
 def authenticate
   deny_access unless signed_in?
 end
 
 def correct_user
   #message = Message.find(params[:id])
   message = Message.find_by_pickUpCode(params[:pickUpCode])
   unless message
     message = Message.find(params[:id])
   end
   @user = message.user
   redirect_to root_path unless current_user?(@user)
 end
  
  #  @message.pickUpCode = Message.generateCode
   
  # if @message.save
  #   redirect_to(@message)
  # else
  #   render :action => 'new'
  # end

  
#  def self.search(search)
#  if search
#    find(:all, :conditions => ['name = ?', "%#{search}%"])
#  else
#    redirect_to()
#  end
#  end
  

end
