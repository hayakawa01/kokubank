class Message include ActiveModel::Model
  attr_accessor :name, :email, :content

  with_options presence: true do
    validates :name, length: {maximum: 20}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, length: {maximum: 30}, format:{ with: VALID_EMAIL_REGEX }
    validates :content, length: {maximum: 200}
  end
end