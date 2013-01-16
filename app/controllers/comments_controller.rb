class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    if @comment.save
      flash[:notice] = "Successfully created comment."
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
    if @comment.update_attributes(params[:comment])
      redirect_to @comment.commentable.event
    else
      render 'edit'
    end
  end

  private

  def find_commentable
    commentable_type = params[:comment][:commentable_type].classify.constantize
    commentable_id = params[:comment][:commentable_id]
    return commentable_type.find(commentable_id.to_i)
    nil
  end
  
end
