require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品が投稿できる場合' do
      it '画像と商品名と説明とカテゴリーと状態と配送料と地域と日数の情報があれば投稿できる' do
        expect(@item).to be_valid
      end
      it '価格が300円だと投稿できる' do
        @item.price = '300'
        expect(@item).to be_valid
      end
      it '価格が9999999円だと投稿できる' do
        @item.price = '9999999'
        expect(@item).to be_valid
      end
    end
    context '商品出品が投稿できない場合' do
      it '画像が空では投稿できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では投稿できない' do
        @item.items_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Items name can't be blank")
      end
      it '商品の説明が空では投稿できない' do
        @item.explain = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explain can't be blank")
      end
      it 'カテゴリーが入力されていなければ投稿できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態が入力されていなければ投稿できない' do
        @item.situation_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Situation can't be blank")
      end
      it '配送料の負担が入力されていなければ投稿できない' do
        @item.delivery_charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end
      it '配送元の地域が入力されていなければ投稿できない' do
        @item.area_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank")
      end
      it '配送までの日数が入力されていなければ投稿できない' do
        @item.shipping_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it '価格が入力されていなければ投稿できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", 'Price is not a number')
      end
      it '価格が299円以下であれば投稿できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '価格が10000000円以上であれば投稿できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '価格が半角数字でなければ投稿できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'userが紐づいていないと投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
