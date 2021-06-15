class PostsController < ApplicationController
  before_action :set_parents,only:[:new,:create,:edit,:update]
  before_action :set_post,only:[:show,:edit,:update,:destroy]
  before_action :correct_edit,only:[:edit,:update,:destroy]
  before_action :search_post
  

  def index
    @posts = Post.includes(:user).order('id DESC').page(params[:page]).per(20)
    selection = params[:keyword]
    @posts_sort = Post.sort(selection)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
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
    @results = @search.result.page(params[:page]).per(20).order('id DESC')
    respond_to do |format|
      format.html
      #ajax通信開始
      format.json do
        # 子の乗法を@childrensに代入してる
        if params[:parent_id]
          @childrens = Grade.find(params[:parent_id]).children
        elsif params[:children_id]
          @grandchildrens = Grade.find(params[:children_id]).children
        end
      end
    end

    selection = params[:keyword]
    @posts = Post.sort(selection)
  end

  
  private

  def post_params
    params.require(:post).permit(:image,:class_name, :detail, :grade_id).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_edit
    unless user_signed_in? && current_user.id == @post.user_id
      redirect_to posts_path
    end
  end

  def set_parents
    @parents = Grade.where(ancestry: nil)
  end
  
end
