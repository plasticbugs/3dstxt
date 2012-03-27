class MessagesController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :destroy]
  before_filter :correct_user, :only => [:edit, :destroy]
    
  def index
    redirect_to :root
    #@message = Message.search(params[:search])
  end

#  def show
#    @message = Message.find_by_pickUpCode(params[:pickUpCode].downcase)
#    return message_show_failed unless !@message.nil?
#    return message_show_succeeded
#  end
#    
#      
#  def message_show_succeeded 
#    @banner_text = "3DStxt.com/#{@message.pickUpCode}"
#    @comments = @message.comments
#    @comment = Comment.new
#    impressionist(@message)
#    
#    display_friend_code if !@message.user.friend_code.nil? && 
#      
#      if !@message.user.nil? && !@message.user.friend_code.nil?
#        @friendcode = format_friend_code(@message.user.friend_code)
#      end
#    
#    @games = @message.user.games
#    
#    if @message.display_games == true  && !@games.nil? && @games.count > 0
#
#      @asins = []
#      @games.each do |game|
#        @asins << game.asin
#      end
#              
#      req = AmazonProduct["us"]
#
#      req.configure do |c|
#        c.key    = AMAZON_KEY
#        c.secret = AMAZON_SECRET
#        c.tag    = AMAZON_ASSOCIATE_TAG
#      end
#
#      req << {  :operation => 'ItemLookup',
#                :search_index => nil,
#                 :response_group => %w{ItemAttributes Images},
#                 :item_id => "#{@asins.join(',')}"
#               }
#      
#      @response = req.get.to_hash
#      @response = @response['Items']['Item']
#      
#      if @response.class == Hash
#        new_array = []
#        new_array << @response
#        @response = new_array
#      end
#      @response = @response.zip(@games)
#    else
#      @response = nil
#    end
#  end
#  end
#  
#  
#  def message_show_failed
#      redirect_to :root
#  end
#  
#  def message_has_a_user?
#    !@message.user_id.nil?
#  end


def show
  @message = Message.find_by_pickUpCode(params[:pickUpCode].downcase)
  return message_show_failed unless !@message.nil?
  return message_show_succeeded
end

def message_show_failed
    redirect_to :root
end
    
def message_show_succeeded 
  @banner_text = "3DStxt.com/#{@message.pickUpCode}"
  @comments = @message.comments
  @comment = Comment.new
  impressionist(@message)
  
  if message_has_a_user?(@message)
    @owner = @message.user
    
    display_friend_code
    display_user_games
  end
end

def display_user_games
    @games = @owner.games
  if !@owner.games.nil? && @message.display_games? && @games.count > 0
    fetch_games_from_amazon
  end
end

def fetch_games_from_amazon
    @asins = []
    @games.each do |game|
      @asins << game.asin
    end
            
    req = AmazonProduct["us"]

    req.configure do |c|
      c.key    = AMAZON_KEY
      c.secret = AMAZON_SECRET
      c.tag    = AMAZON_ASSOCIATE_TAG
    end

    req << {  :operation => 'ItemLookup',
              :search_index => nil,
               :response_group => %w{ItemAttributes Images},
               :item_id => "#{@asins.join(',')}"
             }
    
    @response = req.get.to_hash
    @response = @response['Items']['Item']
    
    if @response.class == Hash
      new_array = []
      new_array << @response
      @response = new_array
    end
    @response = @response.zip(@games)
    return @response
end


def message_has_a_user?(message)
  !message.user_id.nil?
end
  
  def display_friend_code
   if !@owner.friend_code.nil? && @message.display_fc? && @owner.friend_code.length == 12
     @friendcode = format_friend_code(@message.user.friend_code)
     return @friendcode
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
    @banner_text = "Edit 3DStxt.com/#{@message.pickUpCode}"
  end
  
  def update
    @message = Message.find_by_pickUpCode(params[:pickUpCode].downcase)
    @banner_text = "3DStxt.com/#{@message.pickUpCode}"
        
    if @message.update_attributes(params[:message])
      flash[:notice] = 'Your 3DStxt page was successfully updated!'
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
    @message = Message.new params_for_message
    
    return message_create_failed unless @message.save
    return message_create_succeeded
  end
  
  def params_for_message
    params[:message].merge(user: current_user)
  end
  
  def message_create_succeeded
    if signed_in?
      @user = current_user
      @messages = @user.messages
      @comments = @message.comments
      @comment = Comment.new
      @banner_text = "3DStxt.com/#{@message.pickUpCode}"
      
      return render action: 'show', pickUpCode: @message.pickUpCode
    end
    
    return redirect_to action: 'show', pickUpCode: @message.pickUpCode
  end
  
  def message_create_failed
    if signed_in?
      @user = current_user
      @messages = @user.messages
      return render template: 'users/show'
      
    end
    return redirect_to root_url
  end
  
  if false
    
    if signed_in? 
      @user = current_user
      @messages = @user.messages
      @message = Message.new
      @message.user_id = @user.id
      @message.contents(params[:message][:contents])
      @message.pickUpCode(params[:message][:pickUpCode])
      #@message = @user.messages.build(params[:message])
    else
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
