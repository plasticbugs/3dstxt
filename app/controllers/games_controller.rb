include SessionsHelper

class GamesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :search, :create]
  before_filter :correct_user, :only => [:edit, :search, :create]
  
  def new
    @game = Game.new
  end

  def search
  if signed_in?
    @user = current_user
    #User.find(params[:id])
  end
    if params[:query]
    
   req = AmazonProduct["us"]

   req.configure do |c|
     c.key    = AMAZON_KEY
     c.secret = AMAZON_SECRET
     c.tag    = AMAZON_ASSOCIATE_TAG
   end

   req << { :operation => 'ItemSearch',
            :search_index => 'VideoGames',
            :response_group => %w{ItemAttributes Images},
            :keywords => params[:query] + ' 3DS'}

   @response = req.get.to_hash
   @asin = @response['Items']['Item'].first['ASIN']
   
   @game = Game.new(:asin => @asin)
   @game.user_id = @user.id
   @game.save
    end

  end

  
  def create
    #@user = User.find(params[:id])
    @user = current_user
    @game = @user.games.build(params[:game])
    if @game.save
      flash[:notice] = 'Game was successfully added.'
      render :action => "new"
    else
      flash[:error] = 'There was an error adding that game. Please try again.'
      render :action => "new"
    end
  end

  def index
    if signed_in?
    @user = current_user
    @games = @user.games
    
    if @games.count > 0

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
      @response =  @response['Items']['Item']
      
      if @response.class == Hash
        new_array = []
        new_array << @response
        @response = new_array
      end
      @response = @response.zip(@games)
    else
      @response = nil
    end
      
    else
      redirect_to root_path
    end
    
  end

  def update
    @game = Game.find(params[:id])
    
    if @game.update_attributes(params[:game])
      flash[:notice] = 'Game was successfully updated!'
      redirect_to(@game)
    else
      render :action => 'edit'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    flash[:notice] = "Game was successfully deleted."
    redirect_to :action => "index"
  end
  
  private
  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    accessed = User.find_by_id(params[:id])
    #message = Message.find_by_pickUpCode(params[:pickUpCode].downcase)
    @user = accessed
    redirect_to root_path unless current_user?(@user)
  end

end
