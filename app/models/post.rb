class Post < ApplicationRecord
  belongs_to :user
  belongs_to :grade
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image

  
  with_options presence: true do
    validates :class_name,length:{ maximum: 40}
    validates :detail,length:{ maximum: 1000}
    validates :image
  end

  def self.sort(selection)
    case selection
      when 'new'
        return all.order(created_at: :DESC)
      when 'likes'
        return find(Like.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    end
  end

end
