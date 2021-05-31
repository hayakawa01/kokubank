class PostsController < ApplicationController
  def index
  
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

  end

  private
  def post_params
    params.require(:post).permit(:class_name, :detail, :grade_id, :subject_id, :unit_id).merge(user_id: current_user.id)
  end
end
