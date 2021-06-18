require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ﾕｰｻﾞｰ登録ページ' do
    
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

  describe 'ログインページ' do  
    context 'ログインができるとき' do
      it '正確な情報を入力すれば、ログインできpost/indexへ遷移する'  do
        user = FactoryBot.create(:user)
        # トップページに移動
        visit root_path
        # トップページにあるサインアップページへ遷移するボタンがあることを確認
        expect(page).to have_content('ログイン')
        # 新規登録ページへ移動
        visit new_user_session_path
        # ユーザー情報の入力
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        # ログインボタンを押す
        find('input[name="commit"]').click 
        # 投稿一覧ページへ遷移したことを確認
        expect(current_path). to eq(posts_path)
        # ログアウトボタンが表示されることを確認
        expect(page).to have_content("ログアウト")
        # 新規登録ボタンやログインボタンはないことを確認
        expect(page).to have_no_content('会員登録')
        expect(page).to have_no_content('ログイン')
      end
    end
  
    context 'ログインができないとき' do
      it '誤った情報を入力すれば、ログインできずログインページへ戻される'  do
        user = FactoryBot.create(:user)
        # トップページに移動
        visit root_path
        # トップページにあるサインアップページへ遷移するボタンがあることを確認
        expect(page).to have_content('ログイン')
        # 新規登録ページへ移動
        visit new_user_session_path
        # ユーザー情報の入力
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        # ログインボタンを押す
        find('input[name="commit"]').click 
        # 投稿一覧ページへ遷移したことを確認
        expect(current_path). to eq(user_session_path)
      end
    end
  end

  describe 'ユーザー情報編集ページ' do
    context 'ユーザー情報の編集ができるとき' do
      it '正しい情報を入力すれば、ユーザー情報を編集し更新できる' do
        user = FactoryBot.create(:user)
        visit root_path
        expect(page).to have_content('ログイン')
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(posts_path)
        expect(page).to have_content("マイページ")
        visit user_path(user)
        expect(page).to have_content("プロフィールの編集")
        visit edit_user_path(user)
        expect(page).to have_content('会員情報の編集')
        fill_in 'user[nickname]', with: 'e_user.nickname'
        fill_in 'user[email]', with: 'e_user@com'
        select '福島県', from: 'user[prefecture_id]'
        select '1~3年', from: 'user[career_id]'
        select '算数', from: 'user[favorite_subject_id]'
        find('input[name="commit"]').click
        expect(user.reload.nickname).to eq "e_user.nickname"
        expect(user.reload.email).to eq "e_user@com"
        expect(user.reload.prefecture_id).to eq 8
        expect(user.reload.career_id).to eq 2
        expect(user.reload.favorite_subject_id).to eq 3  
      end    
    end

    context 'ユーザー情報の編集ができない' do
      it '誤った情報を入力すれば、ユーザー情報を編集できず編集ページに戻される' do
        user = FactoryBot.create(:user)
        visit root_path
        expect(page).to have_content('ログイン')
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(posts_path)
        expect(page).to have_content("マイページ")
        visit user_path(user)
        expect(page).to have_content("プロフィールの編集")
        visit edit_user_path(user)
        expect(page).to have_content('会員情報の編集')
        fill_in 'user[nickname]', with: ''
        fill_in 'user[email]', with: ''
        select '--', from: 'user[prefecture_id]'
        select '--', from: 'user[career_id]'
        select '--', from: 'user[favorite_subject_id]'
        find('input[name="commit"]').click
        expect(current_path).to eq user_path(user)
      end  
    end
  end

end
