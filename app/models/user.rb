class User < ApplicationRecord
# Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :avatar
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id"
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id"  


#更新の際パスワードが必要なくなる記述
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

#ActiveHash
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :prefecture
    belongs_to :career
    belongs_to :favorite_subject

#バリデーション
  with_options presence: true do
    validates :nickname
    with_options format:{with:  /\A[ぁ-んァ-ヶー-龥々ー]+\z/, message: 'は、全角での入力が必要です'} do
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
  validates :password,format:{with: /\A(?=.*[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "は、半角英数字混合での入力が必須です"},on: :create
  validates :introduction, length: {maximum: 1000}

  #いいね機能
  def already_liked?(post_id)
    likes.where(post_id: post_id).exists?
  end

end
