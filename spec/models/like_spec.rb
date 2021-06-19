require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
    sleep 0.1
  end

  describe 'いいね機能' do
    context 'いいねできるとき'do
      it 'user_id と post_idがあれば、いいねできる' do
        expect(@like).to be_valid
      end  
      
      it 'user_idが同じであっても違うpost_idであれば、いいねできる' do
        like = FactoryBot.create(:like)
        expect(FactoryBot.create(:like, user_id: like.user_id)).to be_valid
      end  
      
      it 'post_idが同じであっても違うuser_idであれば、いいねできる' do
        like = FactoryBot.create(:like)
        expect(FactoryBot.create(:like, post_id: like.post_id)).to be_valid
      end  

    end

    context 'いいねできないとき' do
      it 'user_idが空であれば、いいねできない' do
        @like.user = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("Userを入力してください")
      end  

      it 'post_idが空であれば、いいねできない' do
        @like.post = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("Postを入力してください")
      end  

    end
  end
end
