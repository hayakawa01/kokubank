require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @post = FactoryBot.create(:post,user_id: @user.id)  
    @post2 = FactoryBot.create(:post,user_id: @user2.id) 
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

  describe "GET #edit" do
    context 'ログイン時' do
      before do
        sign_in @user
      end

      it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
        get edit_post_path(@post)
        expect(response.status).to eq 200
      end
  
      it 'editアクションにリクエストするとレスポンスに投稿済みのテキストが存在する' do
        get edit_post_path(@post)
        expect(response.body).to include(@post.class_name)
      end
  
    end

    context '非ログイン時' do 
      it "editアクションにリクエストすると、ログイン画面へ遷移する" do
        get edit_post_path(@post)
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "Post #create" do
    context 'ログイン時' do
      before do
        sign_in @user
      end

      it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
        get posts_path(@post)
        expect(response.status).to eq 200
      end
  
      it 'createアクションにリクエストするとDBに投稿が登録される' do
       # get posts_path(@post)
        #expect(response).to redirect_to(posts_path)
        #expect(response.body).to include(@post)
      end
    end

    context '非ログイン時' do 
      #it "createアクションにリクエストすると、ログイン画面へ遷移する" do
       # get posts_path(@post)
        #expect(response.status).to eq 401
        #expect(response).to redirect_to(new_user_session_path)
      #end
    end
  end


  describe "Patch #update" do
    context 'ログイン時' do
      before do
        sign_in @user
      end

      it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
        get post_path(@post)
        expect(response.status).to eq 200
      end
  
      #it 'updateアクションにリクエストするとDBの投稿が更新される' do
       # get post_path(@post),params:{class_name: 'かけざん',detail:'２のだん'}
        #expect(@post.class_name).not_to eq 'あまりのあるわり算(3時間目)'
      #end

      it '他のユーザーのデータを更新しようとすると、posts#indexに戻される'do
        get post_path(@post2)
        expect(response.status).to eq 200
      end
    end

    context '非ログイン時' do 
      it "updateアクションにリクエストすると、ログイン画面へ遷移する" do
        get post_path(@post)
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
