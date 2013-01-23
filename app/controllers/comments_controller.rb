class CommentsController < ApplicationController
  
  def index
    @comments = Comment.all
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    if @comment.save
      flash[:notice] = "Thanks for your comment"
      redirect_to @commentable.event
    else
      render :action => 'new'
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id]) 
    @comment.update_attributes(params[:comment])
    respond_to do |format|
      format.html { redirect_to @comment.commentable.event }
      format.json { render :json => @comment }
    end      
  end
  
  def destroy
    @comment = Comment.find(params[:id]) 
    @comment.destroy
    flash[:notice] = "Comment was destroyed"
    redirect_to @comment.commentable.event  
  end

  private

  def find_commentable
    commentable_type = params[:comment][:commentable_type].classify.constantize
    commentable_id = params[:comment][:commentable_id]
    return commentable_type.find(commentable_id.to_i)
    nil
  end
  
  def current_resource
    @current_resource ||= Comment.find(params[:id]) if params[:id]
  end
  
end
