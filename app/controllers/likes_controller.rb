class LikesController < ApplicationController
  before_action :authenticate_user!,only: [:create,:destroy]
  before_action :post_params,only: [:create,:destroy]

  def create
    Like.create(user_id: current_user.id, post_id: @post.id)
    #通知の設定
    @post.create_notification_by(current_user)
    respond_to do |format|
      format.html{redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: @post.id)
    like.destroy
  end

  private
  def post_params
    @post = Post.find(params[:post_id])
  end

end
