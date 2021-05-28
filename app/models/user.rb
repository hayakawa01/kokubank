class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :career
  belongs_to :favorite_subject


  with_options presence: true do
    validates :nickname
    with_options format:{with: /\A[ぁ-んァ-ヶ-ー龥々ー]+\z/, message: 'は、全角での入力が必要です'} do
      validates :family_name
      validates :first_name      
    end
    with_options format:{with: /\A[ァ-ヶーー]+\z/, message: 'は、全角カタカナでの入力が必要です'} do
      validates :family_name_kana
      validates :first_name_kana
    end
    with_options numericality: {other_than: 1} do
      validates :prefecture_id
      validates :career_id
      validates :favorite_subject_id
    end
  end
  validates :introduction, length: {maximum: 1000}
end
