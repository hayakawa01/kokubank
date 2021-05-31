class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameter,if: :devise_controller?


  private
  def configure_permitted_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:first_name, :family_name, :first_name_kana, :family_name_kana, :favorite_subject_id, :prefecture_id, :career_id, :introduction])
  end
end
