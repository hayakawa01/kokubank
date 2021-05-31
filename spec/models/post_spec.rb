require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  context "新規投稿できるとき"do
    it 'すべての項目が記入されていれば投稿できる' do
      expect(@post).to be_valid
    end

    it 'class_nameが40字以内であれば投稿できる' do
      @post.class_name = "カンジ―博士の部屋(2時間目)"
      expect(@post).to be_valid
    end
    
    it 'detailが1000字以内であれば投稿できる' do
      @post.detail = "あいうえおかきくけこさしすせそ"
      expect(@post).to be_valid
    end
  end
  
  context "新規投稿できないとき"do
    it 'class_nameが空であれば投稿できない' do
      @post.class_name = ''
      @post.valid?
      expect(@post.errors.full_messages).to include("授業名を入力してください")
    end

    it 'class_nameが41字以上であれば投稿できない' do
      @post.class_name = "あ" * 41
      @post.valid?
      expect(@post.errors.full_messages).to include("授業名は40文字以内で入力してください")
    end

    it 'detailが空であれば投稿できない' do
      @post.detail = ''
      @post.valid?
      expect(@post.errors.full_messages).to include("授業の詳細を入力してください")

    end
    it 'detailが1001字以上であれば投稿できない' do
      @post.detail = "あ" * 1001
      @post.valid?
      expect(@post.errors.full_messages).to include("授業の詳細は1000文字以内で入力してください")
    end

    it 'imageが空であれば投稿できない' do
      @post.image = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("画像を入力してください")
    end

    it 'grade_idが1であれば投稿できない' do  
      @post.grade_id = 1
      @post.valid?
      expect(@post.errors.full_messages).to include("学年は1以外の値にしてください")
    end

    it 'subject_idが1であれば投稿できない' do
      @post.subject_id = 1
      @post.valid?
      expect(@post.errors.full_messages).to include("教科は1以外の値にしてください")       
    end

    it 'unit_idが1であれば投稿できない' do
      @post.unit_id = 1
      @post.valid?
      expect(@post.errors.full_messages).to include("単元は1以外の値にしてください")
    end

  end
end
