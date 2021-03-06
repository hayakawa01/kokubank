require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント機能' do
    context 'コメントできるとき' do
      it 'textが入力されていれば、コメントできる' do
        expect(@comment).to be_valid
      end

    end
    
    context 'コメントできないとき' do
      it 'textが空なら、コメントできない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントを入力してください")
      end

      it 'user_idが空であれば、コメントできない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Userを入力してください")
      end  

      it 'post_idが空であれば、コメントできない' do
        @comment.post = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Postを入力してください")
      end  
      
    end
  end
end
