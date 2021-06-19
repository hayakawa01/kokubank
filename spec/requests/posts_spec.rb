require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)  
  end

  describe "GET #index" do
    context 'ログイン時' do
      before do
        sign_in @user
      end
      it "indexアクションにリクエストすると、正常にレスポンスが返ってくる" do
        get posts_path
        expect(response.status).to eq 200
      end
  
      it "indexアクションにリクエストすると、レスポンスに投稿済みのテキストが存在する" do
        get posts_path
        expect(response.body).to include(@post.class_name)
      end
    end

    context '非ログイン時'do
      it "indexアクションにリクエストすると、ログイン画面へ遷移する" do
        get posts_path
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #new" do
    context 'ログイン時' do
      before do
        sign_in @user
      end
      it "newアクションにリクエストすると、正常にレスポンスが返ってくる" do
        get posts_path
        expect(response.status).to eq 200
      end
    end
    context '非ログイン時'do
      it "indexアクションにリクエストすると、ログイン画面へ遷移する" do
        get posts_path
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end




  describe "GET #show" do
    context 'ログイン時' do
      before do
        sign_in @user
      end

      it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
        get post_path(@post)
        expect(response.status).to eq 200
      end
  
      it 'showアクションにリクエストするとレスポンスに投稿済みのテキストが存在する' do
        get post_path(@post)
        expect(response.body).to include(@post.class_name)
      end
  
      it 'showアクションにリクエストするとレスポンスにコメントの注意書きが存在する' do
        get post_path(@post)
        expect(response.body).to include("※相手のことを考え丁寧なコメントを心がけましょう。")
      end
    end

    context '非ログイン時' do 
      it "showアクションにリクエストすると、ログイン画面へ遷移する" do
        get post_path(@post)
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
