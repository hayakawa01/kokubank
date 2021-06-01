class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end

  end
  
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @posts = @user.posts
  end

  private
  def user_params
    params.require(:user).permit(:nickname,:email,:favorite_subject_id, :prefecture_id, :career_id, :introduction)
  end
end
