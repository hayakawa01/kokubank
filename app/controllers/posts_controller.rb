class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).order('id DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    unless user_signed_in? && current_user.id == @post.user_id
      redirect_to root_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:image,:class_name, :detail, :grade_id, :subject_id, :unit_id).merge(user_id: current_user.id)
  end
end
