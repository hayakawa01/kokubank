require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do

      it '全てが正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end   

      it 'パスワードが6文字以上の半角英数字混合であれば登録できる' do
        @user.password = "000aaa"
        @user.password_confirmation = "000aaa"
        expect(@user).to be_valid
      end

      it 'family_nameが全角であれば登録できる' do
        @user.family_name = "山田"
        expect(@user).to be_valid
      end

      it 'first_nameが全角であれば登録できる' do
        @user.first_name = "太郎"
        expect(@user).to be_valid
      end

      it 'family_name_kanaが全角カナであれば登録できる' do
        @user.family_name_kana = "ヤマダ"
        expect(@user).to be_valid
      end

      it 'first_name_kanaが全角カナであれば登録できる' do
        @user.first_name_kana = "タロウ"
        expect(@user).to be_valid
      end
    end 

    context '新規登録がうまくいかないとき' do

      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it 'emailに@が入っていない場合は登録できない' do
        @user.email = "yamadacom"
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end

      it 'emailがすでに存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user,email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが半角英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include( "パスワードは、半角英数字混合での入力が必須です")
      end

      it 'passwordが半角数字のみでは登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include( "パスワードは、半角英数字混合での入力が必須です")
      end

      it 'passwordが6文字以内の半角英数字では登録できない' do
        @user.password = '00aa'
        @user.valid?
        expect(@user.errors.full_messages).to include( "パスワードは6文字以上で入力してください")
      end

      it 'passwordが全角入力では登録できない' do
        @user.password = '０００ｐｐｐ'
        @user.valid?
        expect(@user.errors.full_messages).to include( "パスワードは、半角英数字混合での入力が必須です")
      end

      it 'passwordとpassword_confirmationが違う場合は登録できない' do
        @user.password = '000aaa'
        @user.password_confirmation = '111aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード(確認)とパスワードの入力が一致しません")
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end

      it 'family_nameが全角でない場合は登録できない' do
        @user.family_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字は、全角での入力が必要です")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it 'first_nameが全角でない場合は登録できない' do
        @user.first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は、全角での入力が必要です")
      end

      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字カナを入力してください")
      end

      it 'family_name_kanaが全角カタカナでない場合は登録できない' do
        @user.family_name_kana = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字カナは、全角カタカナでの入力が必要です")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前カナを入力してください")
      end

      it 'first_name_kanaがが全角カタカナでない場合は登録できない' do
        @user.first_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前カナは、全角カタカナでの入力が必要です")
      end

      it 'prefecture_idが1であれば投稿できない' do 
        @user.prefecture_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("勤務都道府県は1以外の値にしてください")
      end

      it 'caerer_idが1であれば投稿できない' do
        @user.career_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("勤務年数は1以外の値にしてください")
      end

      it 'favorite_subject_idが1であれば投稿できない' do
        @user.favorite_subject_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("得意教科は1以外の値にしてください")
      end
    end 
  end
end
