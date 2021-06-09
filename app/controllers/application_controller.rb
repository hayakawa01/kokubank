class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameter,if: :devise_controller?
  before_action :basic_auth
  before_action :search_post


  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def configure_permitted_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :family_name, :first_name_kana, :family_name_kana, :favorite_subject_id, :prefecture_id, :career_id, :introduction, :avatar])
  end

  def search_post
    @p = Post.ransack(params[:q])
    @search_p = @p.result(distinct: true)
  end
end
