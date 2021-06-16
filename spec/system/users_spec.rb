require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正確な情報を入力すれば、登録できpost/indexへ遷移する'  do
      # トップページに移動
      visit root_path
      # トップページにあるサインアップページへ遷移するボタンがあることを確認
      expect(page).to have_content('会員登録')
      # 新規登録ページへ移動
      visit new_user_registration_path
      # ユーザー情報の入力
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      fill_in 'user[family_name]', with: @user.family_name
      fill_in 'user[first_name]', with: @user.first_name
      fill_in 'user[family_name_kana]', with: @user.family_name_kana
      fill_in 'user[first_name_kana]', with: @user.first_name_kana
      select '北海道', from: 'user[prefecture_id]'
      select '1~3年', from: 'user[career_id]'
      select '国語', from: 'user[favorite_subject_id]'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # 投稿一覧ページへ遷移したことを確認
      expect(current_path). to eq(posts_path)
      # ログアウトボタンが表示されることを確認
      expect(page).to have_content("ログアウト")
      # 新規登録ボタンやログインボタンはないことを確認
      expect(page).to have_no_content('会員登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報を入力すれば、登録できずdevise/registrationへ戻ってくる'  do
      # トップページに移動
      visit root_path
      # トップページにあるサインアップページへ遷移するボタンがあることを確認
      expect(page).to have_content("会員登録")
      # 新規登録ページへ移動
      visit new_user_registration_path
      # ユーザー情報の入力（誤入力）
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      fill_in 'user[family_name]', with: @user.family_name
      fill_in 'user[first_name]', with: @user.first_name
      fill_in 'user[family_name_kana]', with: @user.family_name_kana
      fill_in 'user[first_name_kana]', with: @user.first_name_kana
      select '--', from: 'user[prefecture_id]'
      select '--', from: 'user[career_id]'
      select '--', from: 'user[favorite_subject_id]'
      # サインアップボタンを押してもユーザーモデルのカウントが上がらないことを確認
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻ってくることを確認
      expect(current_path).to eq(user_registration_path)
    end

  end

end
