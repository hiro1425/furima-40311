FactoryBot.define do
  factory :item do
    items_name { 'カラーコーン' }
    explain { '2年前に購入したものです' }
    category_id           { 3 }
    situation_id          { 3 }
    delivery_charge_id    { 3 }
    area_id               { 3 }
    shipping_day_id       { 3 }
    price                 { 7000 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
