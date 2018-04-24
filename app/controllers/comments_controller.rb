class CommentsController < ApplicationController
  def create
    comment_params = params.require(:comment).permit(:body)
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post #this comment is referring to which post
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post)
    else
      @comments = @post.comments.order(created_at: :desc)
      render 'posts/show'
    end
  end

  def destroy
    comment = Comment.find params[:id]

    unless can?(:manage, comment)
      flash[:alert] = "Access Denied"
      redirect_to post_path(comment.post)
      return
    end
    comment.destroy
    redirect_to post_path(comment.post)
  end

end
