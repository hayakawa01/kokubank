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
    #with_options numericality: {other_than: 1} do
      #validates :grade_id
    #end
  end

end
