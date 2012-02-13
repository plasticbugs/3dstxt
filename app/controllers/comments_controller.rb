class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @message = Message.find(params[:message_id])
    @comment = @message.comments.create(params[:comment])
    flash[:notice] = "Comment was successfully posted at the bottom of the page."
    
    redirect_to :action => 'show', :pickUpCode => @message.pickUpCode, :controller => 'messages'
  end
    

  def destroy
    @message = Message.find(params[:message_id])
    @comment = @message.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment was successfully deleted."
    redirect_to :back
  end

end
