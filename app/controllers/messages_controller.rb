class MessagesController < ApplicationController
  def index
    #@message = Message.search(params[:search])
  end

  def show
    @message = Message.find_by_pickUpCode(params[:pickUpCode])
  end

  def new
   @message = Message.new
  end

  def edit
  end
  
  def create
    @message = Message.new(params[:message])
        
    if @message.save
      flash[:notice] = 'Message was successfully created.'
      redirect_to :action => "show", :pickUpCode => @message.pickUpCode
    else
      render :action => "new"
    end
    
  #  @message.pickUpCode = Message.generateCode
   
  # if @message.save
  #   redirect_to(@message)
  # else
  #   render :action => 'new'
  # end
  end
  
  def self.search(search)
#  if search
#    find(:all, :conditions => ['name = ?', "%#{search}%"])
#  else
#    redirect_to()
#  end
  end
  

end
