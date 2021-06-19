require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "ユーザー登録（devise/registration#new）" do 
    it 'newアクションにリクエストを送ると正常なレスポンスが返ってくること'do
      get new_user_registration_path
      expect(response.status).to eq 200
    end

    it 'newアクションにリクエストするとレスポンスに会員登録フォームが存在すること' do
      get new_user_registration_path
      expect(response.body).to include('会員登録フォーム')
    end
  end

  describe "ユーザーログイン（devise/session#new）" do 
    it 'newアクションにリクエストを送ると正常なレスポンスが返ってくること'do
      get new_user_session_path
      expect(response.status).to eq 200
    end

    it 'newアクションにリクエストするとレスポンスに会員登録フォームが存在すること' do
      get new_user_session_path
      expect(response.body).to include('ログインフォーム')
    end
  end

  describe "ユーザー詳細：ログイン時（#show）" do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    it 'showアクションにリクエストを送ると正常なレスポンスが返ってくること'do
      get user_path(@user)
      expect(response.status).to eq 200
    end

    it 'showアクションにリクエストするとレスポンスにマイページが存在すること' do
      get user_path(@user)
      expect(response.body).to include('マイページ')
    end
  end

  
end
