class Post < ApplicationRecord
  belongs_to :user
  belongs_to :grade
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one_attached :image


  
  with_options presence: true do
    validates :class_name,length:{ maximum: 40}
    validates :detail,length:{ maximum: 1000}
    validates :image
  end
 
  #ソート機能のメソッド
  def self.sort(selection)
    case selection
      when 'new'
        return all.order(created_at: :DESC)
      when 'likes'
        return find(Like.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    end
  end

  #いいね通知機能のメソッド
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  # コメント通知機能のメソッド
  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      item_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    #自分の投稿に対する自分のコメントは通知済みなので通知されないように
    if notification.visiter_id == notification.visited_id
      notification.check = true
    end
    notification.save if notification.valid?
  end

end
