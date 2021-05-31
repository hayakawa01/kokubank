class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :grade
    belongs_to :subject
    belongs_to :unit

  with_options presence: true do
    validates :class_name
    validates :detail
  end

end
