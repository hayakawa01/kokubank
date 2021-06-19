require 'rails_helper'

RSpec.describe Notification, type: :model do
  before do
    @notification = FactoryBot.build(:notification)
  end
  context'通知がうまくいく'do
    it "notificationインスタンスが有効であること" do
      expect(@notification).to be_valid
    end 
  end
  context '通知がうまくいかない'do
    it "visiter_idがnilの場合、無効であること" do
      @notification.user_id = nil
      expect(notification).not_to be_valid
    end

    it "visited_idがnilの場合、無効であること" do
      @notification.from_user_id = nil
      expect(notification).not_to be_valid
    end

    it "post_idがnilの場合、無効であること" do
      @notification.dish_id = nil
      expect(notification).not_to be_valid
    end

    it "actionがnilの場合、無効であること" do
      @notification.variety = nil
      expect(notification).not_to be_valid
    end
  end
end
