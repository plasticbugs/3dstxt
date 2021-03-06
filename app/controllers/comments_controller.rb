class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
      @message = Message.find(params[:message_id])
   if verify_recaptcha
      @comment = @message.comments.build(params[:comment])
      @comment.content = Sanitize.clean(@comment.content, Sanitize::Config::BASIC)
      @comment.user_agent = request.user_agent
      @comment.referrer = request.referer
      @comment.user_ip = request.remote_ip
      @comment.permalink = request.url
       if @comment.save

        if @comment.message.user != nil
          unless @comment.author_email == @comment.message.user.email
            UserMailer.comment_alert(@comment).deliver if @comment.message.user.comment_alert == true
          end
        end
                
          flash[:notice] = "Comment was successfully posted at the bottom of the page."
          redirect_to :action => 'show', :pickUpCode => @message.pickUpCode, :controller => 'messages'
  
        else
          #@message = @comment.message
          #redirect_to :action => 'show', :pickUpCode => @message.pickUpCode, :controller => 'messages'
          flash[:errors] = @comment.errors.full_messages
          redirect_to :back
        end
   else
      redirect_to :back
      flash[:notice] = "Sorry, please try entering your comment again. The ReCaptcha was incorrect."
    end

        
  end
    

  def destroy
    @message = Message.find(params[:message_id])
    @comment = @message.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment was successfully deleted."
    redirect_to :back
  end

end
