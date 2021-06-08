class GradesController < ApplicationController
  before_action :set_grade,only:[:show]
  def index
    @parents = Grade.where(ancestry: nil)
  end

  def show
    @posts = @grade.set_posts
    @posts = @posts.where(user_id: nil).order("id DESC").page(params[:page]).per(9)
  end

  private
  def set_grade
    @grade = Grade.find(params[:id])
    if @grade.has_children?
      @grade_links = @grade.children
    else
      @grade_links = @grade.siblings
    end
  end
end
