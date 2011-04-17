class MessagesController < ApplicationController
  before_filter :authenticate, :only => [:edit]
  before_filter :correct_user, :only => [:edit]
  
  def index
    redirect_to :root
    #@message = Message.search(params[:search])
  end

  def show
    @message = Message.find_by_pickUpCode(params[:pickUpCode].downcase)
  end

  def new
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
      @message = current_user.messages.build(params[:message])
      if @message.pickUpCode.blank?
        charset = %w{ 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z }
        @message.pickUpCode = (0...5).map{ charset.to_a[rand(charset.size)] }.join

        while Message.find_by_pickUpCode(@message.pickUpCode.downcase, size = 5)
          @message.pickUpCode = (0...5).map{ charset.to_a[rand(charset.size)] }.join
        end
      end
      @messages = current_user.messages
      @user = current_user
      
    else
      @message = Message.new(params[:message])
    end
        
    if @message.save
      flash[:notice] = 'Your message was created!'
      redirect_to :action => "show", :pickUpCode => @message.pickUpCode
    elsif signed_in?
      render :action => 'users/show'
    else
      # flash[:notice] = ":("
      # redirect_to root_path, {:flash => "!"}
      
      redirect_to root_url, :notice => "Message must be between 1 and 5000 chars"
    end
  end
    
    
 def destroy
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
   message = Message.find_by_pickUpCode(params[:pickUpCode].downcase)
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
