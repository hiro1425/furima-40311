class BuyAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :postal_code, :area_id, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "is invalid. Input full-width characters."}
    validates :address
    validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "は10桁または11桁の数字で入力してください"}
  end
  validates :area_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    buy = Buy.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, area_id: area_id, city: city, address: address, building: building, phone_number: phone_number, buy_id: buy.id)
  end
end