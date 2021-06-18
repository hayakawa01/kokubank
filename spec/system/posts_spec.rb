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
        select '小1', from: 'grade_form'
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
        expect(page).to have_content('バスケットボール')
      end
    end
    context '新規投稿ができない' do
      it '投稿に関する情報が不足していると投稿画面に戻される' do
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
        fill_in 'post[class_name]',with: ''
        fill_in 'post[detail]',with: ''
        # プルダウン（親）の中から、「小１」を選択
        select '小1', from: 'grade_form'
        sleep 0.5 
        # プルダウン（子）の中から、「国語」を選択
        select '国語', from: 'post_grade_id2'
        sleep 0.5 
        # プルダウン（孫）の中から、「物語」を選択
        select '物語', from: 'post_grade_id3'
        find('input[name="commit"]').click
        # 投稿が失敗すれば、投稿一覧ページへ遷移する
        expect(current_path).to eq(posts_path)
      end
    end
  end

  describe '投稿の詳細ページ' do 
    before do
      @post1 = FactoryBot.create(:post)
      @post2 = FactoryBot.create(:post,class_name:'かけ算')
    end

    context '投稿の編集ができるとき' do
      it 'ログインしたユーザーは自分の投稿の編集ができる' do
        # post1を投稿したユーザーでログインする
        visit new_user_session_path
        fill_in 'user[email]', with: @post1.user.email
        fill_in 'user[password]', with: @post1.user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(posts_path)
        # post1の投稿詳細ページへ遷移する
        visit post_path(@post1)
        # post1に「編集する」があることを確認する
        expect(page).to have_content('編集する')
        # 編集ページへ遷移する
        visit edit_post_path(@post1)
        # すでに投稿済みの内容がフォームに入っていることを確認する
        expect(
          find('#post_class_name').value # post_textというid名が付与された要素の値を取得
        ).to eq(@post1.class_name)
        # 投稿内容を編集する
        fill_in 'post[class_name]', with: "#{@post1.class_name}+あ"
        # 添付する画像を定義する
        image_path = Rails.root.join('app/assets/images/bansyo2.jpg')
        # 画像選択フォームに画像を添付する
        attach_file('post[image]', image_path)
        # 編集してもPostモデルのカウントは変わらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { Post.count }.by(0)
        # 投稿詳細画面に遷移したことを確認する
        expect(current_path).to eq(post_path(@post1))
        # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
        expect(page).to have_selector('img')
        # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
        expect(page).to have_content("#{@post1.class_name}+あ")
      end
    end

    context '投稿の編集ができないとき' do
      it 'ログインしたユーザーは自分以外が投稿した投稿の編集画面には遷移できない' do
        # post1を投稿したユーザーでログインする
        visit new_user_session_path
        fill_in 'user[email]', with: @post1.user.email
        fill_in 'user[password]', with: @post1.user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(posts_path)
        visit post_path(@post2)
        # post2の詳細ページには「編集」ボタンがないことを確認する
        expect(page).to have_no_content('編集する')
      end
    end


    context '投稿の削除ができる' do
      it 'ログインしたユーザーは自分の投稿した投稿を削除できる'do
        # post1を投稿したユーザーでログインする
        visit new_user_session_path
        fill_in 'user[email]', with: @post1.user.email
        fill_in 'user[password]', with: @post1.user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(posts_path)
        # post1の投稿詳細ページへ遷移する
        visit post_path(@post1)
        # post1に「削除する」があることを確認する
        expect(page).to have_content('削除する')
        expect{find_link('削除する', href: post_path(@post1)).click
          }.to change { Post.count }.by(-1)
        # 投稿一覧ページに遷移する
        visit posts_path
        # 投稿一覧ページにはpost1の内容が存在しないことを確認する（授業名で）
        expect(page).to have_no_content("あまりのあるわり算(3時間目)")
      end
    end

    context '投稿の削除ができない' do
      it 'ログインしたユーザーは自分以外の投稿した投稿の編集画面に遷移できない'do
        # post1を投稿したユーザーでログインする
        visit new_user_session_path
        fill_in 'user[email]', with: @post1.user.email
        fill_in 'user[password]', with: @post1.user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(posts_path)
        visit post_path(@post2)
        # post2の詳細ページには「削除する」がないことを確認する
        expect(page).to have_no_content('削除する')
      end
    end
  end
end