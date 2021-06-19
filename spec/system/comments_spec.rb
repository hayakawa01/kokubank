require 'rails_helper'

RSpec.describe "Comments", type: :system do
  describe 'コメント機能' do
    context 'コメントできる' do
      it 'ログインしたユーザーはツイート詳細ページに遷移すればコメント投稿欄が表示される' do
        @post = FactoryBot.create(:post)
        @comment = FactoryBot.create(:comment)
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
        # 投稿詳細ページへ
        visit post_path(@post)
        # 詳細ページにはコメントフォームがある
        expect(page).to have_selector('form')
        # コメントを入力する
        fill_in 'comment[text]', with: @comment
        # コメントを送信すると、Commentモデルのカウントが１増える
        expect{
          find('input[name="commit"]').click
        }.to change { Comment.count }.by(1)
        expect(page).to have_content(@comment)
      end
    end

    context 'コメントの削除'do
      it 'ログインしてコメントをしたユーザーであれば、そのコメントの削除ができる' do
        @post = FactoryBot.create(:post)
        @comment = FactoryBot.create(:comment)
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
        # 投稿詳細ページへ
        visit post_path(@post)
        # 詳細ページにはコメントフォームがある
        expect(page).to have_selector('form')
        # コメントを入力する
        fill_in 'comment[text]', with: @comment
        # コメントを送信すると、Commentモデルのカウントが１増える
        expect{
          find('input[name="commit"]').click
        }.to change { Comment.count }.by(1)
        expect(page).to have_content(@comment)
        find('.comment-delete').click
        expect(page).to have_no_content(@comment)
      end

      it 'ログインしたユーザーは自分の投稿したコメントでなければ、そのコメントの削除ができない' do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post,user_id: @user.id)
        @comment = FactoryBot.create(:comment,user_id: @user.id,post_id: @post.id)
        @user2 = FactoryBot.create(:user)
        @comment2 = FactoryBot.create(:comment,user_id: @user2.id)
        # @user２ のログイン
        visit new_user_session_path
        fill_in 'user[email]', with: @user2.email
        fill_in 'user[password]', with: @user2.password
        find('input[name="commit"]').click
        # ログインすると投稿一覧ページへ遷移
        expect(current_path).to eq(posts_path)
        # 投稿詳細ページへ
        visit post_path(@post)
        # 詳細ページにはコメントフォームがある
        expect(page).to have_selector('form')
        # 詳細ページには@userのコメントがある
        expect(page).to have_content(@comment.text)
        # @suerのコメントなので@user2の見ているページにはには削除するセレクタがない
        expect(page).to have_no_selector('.comment-delete')
      end
    end
  end
end
