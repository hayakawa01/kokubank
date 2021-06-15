class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments.includes(:user).order('id DESC')
    @comment = Comment.new(comment_params)
    @comment_post = @comment.post
    if @comment.save
       #通知の設定
       @comment_post.create_notification_comment!(current_user, @comment.id)
      redirect_back(fallback_location: root_path)
    else
      render "posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if current_user.id == @comment.user.id
      @comment.destroy
    redirect_back(fallback_location: root_path)
    else
      render "posts/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
