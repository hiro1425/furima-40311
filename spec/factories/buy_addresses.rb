FactoryBot.define do
  factory :buy_address do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code { '123-4567' }
    area_id { 41 }
    city { '福岡市' }
    address { '1-1' }
    building { '福岡ハイツ' }
    phone_number { "0" + "9012345678" }
  end
end