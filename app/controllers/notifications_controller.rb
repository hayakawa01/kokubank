class NotificationsController < ApplicationController
  def index
    #currentuserの投稿に紐付いた通知全て
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    #@notificationdの中でまだ確認していない通知のみ,全て確認されたようにする
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy_all
    #通知の全削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
