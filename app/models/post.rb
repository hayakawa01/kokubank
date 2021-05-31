class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :grade
    belongs_to :subject
    belongs_to :unit

  with_options presence: true do
    validates :class_name,length:{ maximum: 40}
    validates :detail,length:{ maximum: 1000}
    validates :image
    with_options numericality: {other_than: 1} do
      validates :grade_id
      validates :subject_id
      validates :unit_id
    end
  end

end
