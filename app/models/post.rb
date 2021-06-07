class Post < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image

  with_options presence: true do
    validates :class_name,length:{ maximum: 40}
    validates :detail,length:{ maximum: 1000}
    validates :image
  end

end
