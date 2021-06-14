class UsersController < ApplicationController
 before_action :set_user, only:[ :edit, :update, :show, :likes]

  def edit
  end

  def update
    if @user == current_user
      @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  def show
    @nickname = @user.nickname
    @posts = @user.posts
  end

  def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :email, :favorite_subject_id, :prefecture_id, :career_id, :introduction, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
