require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  describe '購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @buy_address = FactoryBot.build(:buy_address, user_id: @user.id, item_id: @item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば購入できること' do
        expect(@buy_address).to be_valid
      end
      it 'buildingは空でも購入できること' do
        @buy_address.building = ''
        expect(@buy_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it "tokenが空では登録できないこと" do
        @buy_address.token = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include()
      end
      it 'postal_codeが空だと購入できないこと' do
        @buy_address.postal_code = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeがハイフンを含んだ正しい形式でないと購入できないこと' do
        @buy_address.postal_code = '1234567'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeが「3桁ハイフン4桁」の半角文字列のみでないと購入できないこと' do
        @buy_address.postal_code = '123-４５６７'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'areaを選択していないと購入できないこと' do
        @buy_address.area_id = '1'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Area can't be blank")
      end
      it 'cityが空だと購入できないこと' do
        @buy_address.city = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("City can't be blank", "City is invalid. Input full-width characters.")
      end
      it 'addressが空だと購入できないこと' do
        @buy_address.address = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと購入できないこと' do
        @buy_address.phone_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number can't be blank", "Phone number は10桁または11桁の数字で入力してください")
      end
      it 'phone_numberが9桁以下だと購入できないこと' do
        @buy_address.phone_number = '090300012'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number は10桁または11桁の数字で入力してください")
      end
      it 'phone_numberが12桁以上だと購入できないこと' do
        @buy_address.phone_number = '090123456789'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number は10桁または11桁の数字で入力してください")
      end
      it 'phone_numberが半角数値でないと購入できないこと' do
        @buy_address.phone_number = '０９０12345678'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number は10桁または11桁の数字で入力してください")
      end
      it 'user_idが紐づいていなければ購入できないこと' do
        @buy_address.user_id = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていなければ購入できないこと' do
        @buy_address.item_id = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

