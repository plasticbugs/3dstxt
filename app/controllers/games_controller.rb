class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def search
    req = AmazonProduct["us"]

    req.configure do |c|
      c.key    = AMAZON_KEY
      c.secret = AMAZON_SECRET
      c.tag    = AMAZON_ASSOCIATE_TAG
    end

    req << { :operation => 'ItemSearch',
             :search_index => 'VideoGames',
             :keywords => params[:query] + ' 3DS'}

    @response = req.get.to_hash
    @asin = @response['Items']['Item'].first['ASIN']
    @user = User.find(params[:id])
    @game = Game.new(:asin => @asin)
    @game.user_id = @user.id
    @game.save
    render :action => "search"
#    render :json => "oop"
  end

  
  def create
    @user = User.find(params[:id])
    @game = @user.games.build(params[:game])
    if @game.save
      flash[:notice] = 'Game was successfully created.'
      redirect_to(@game)
    else
      render :action => "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @games = @user.games
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
    redirect_to :action => "show"
  end

end
