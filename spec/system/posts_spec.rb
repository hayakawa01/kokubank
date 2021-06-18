require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe '新規投稿ページ' do
    context '新規投稿ができる' do
      it '正確な情報を入力し投稿すれば、投稿一覧ページへ遷移する' do   
        @user = FactoryBot.create(:user)
        # @user のログイン
        visit root_path
        expect(page).to have_content('ログイン')
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        find('input[name="commit"]').click
        # ログインすると投稿一覧ページへ遷移
        expect(current_path).to eq(posts_path)
        expect(page).to have_content('投稿する')
        # 投稿するのリンクをクリックすると、新規投稿画面へ遷移
        visit new_post_path
        # 必要な情報を入れる（class_name, detail, grade（プルダウンのカテゴリ））
        image_path = Rails.root.join('app/assets/images/bansyo2.jpg')
        attach_file('post[image]', image_path)
        fill_in 'post[class_name]',with: 'バスケットボール'
        fill_in 'post[detail]',with: 'シュート20回'
        # プルダウン（親）の中から、「小１」を選択
        select '小1', from: 'post_grade_id'
        sleep 0.5 
        # プルダウン（子）の中から、「国語」を選択
        select '国語', from: 'post_grade_id2'
        sleep 0.5 
        # プルダウン（孫）の中から、「物語」を選択
        select '物語', from: 'post_grade_id3' 
        find('input[name="commit"]').click
        # 投稿が成功すれば、投稿一覧ページへ遷移する
        expect(current_path).to eq(posts_path)
        # 投稿一覧には先程投稿した投稿が存在する
        expect(page). to include('バスケットボール')
      end
    end
  end
end