class PostsController < ApplicationController
  before_action :set_post,only:[:show,:edit,:update,:destroy]
  before_action :correct_edit,only:[:edit,:update,:destroy]
  before_action :search_post,only:[:index,:search]
  

  def index
    @posts = Post.includes(:user).order('id DESC').page(params[:page]).per(9)
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
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order('id DESC')
  end

  def edit    
  end

  def update
    if @post.update(post_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def search
    @results = @p.result.page(params[:page]).per(9).order('id DESC')
  end

  
  private

  def post_params
    params.require(:post).permit(:image,:class_name, :detail, :grade_id, :subject_id, :unit_id).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_edit
    unless user_signed_in? && current_user.id == @post.user_id
      redirect_to root_path
    end
  end

  def search_post
    @p = Post.ransack(params[:q])
    @search_p = @p.result
  end
  
end
