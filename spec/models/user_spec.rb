require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context 'ユーザー情報' do
      it 'nicknameが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = 'test1'
        @user.password_confirmation = 'test1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが英字だけだと登録できない' do
        @user.password = 'aaaaaaaa'
        @user.password_confirmation = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と半角数字の両方を含めて設定してください')
      end
      it 'passwordが数字だけだと登録できない' do
        @user.password = '11111111'
        @user.password_confirmation = '11111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と半角数字の両方を含めて設定してください')
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = 'test123'
        @user.password_confirmation = 'test1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
    context '本人情報確認' do
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = 'aaaaaa'
        @user.first_name = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください', 'Last name 全角文字を使用してください')
      end
      it 'お名前カナ(全角)は、名字が必須であること' do
        @user.name_kana_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana last name can't be blank")
      end
      it 'お名前カナ(全角)は、名前が必須であること' do
        @user.name_kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana first name can't be blank")
      end
      it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.name_kana_last_name = '試験'
        @user.name_kana_first_name = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana last name 全角カタカナを使用してください',
                                                      'Name kana first name 全角カタカナを使用してください')
      end
      it '生年月日が必須であること' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end
  end
end
