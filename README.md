## usersテーブル

| Column               | Type   | Options     |
|----------------------|--------|-------------|
| nickname             | string | null: false |
| email                | string | null: false unique: true|
| encrypted_password   | string | null: false |
| last_name            | string | null: false |
| first_name           | string | null: false |
| name_kana_last_name  | string | null: false |
| name_kana_first_name | string | null: false |
| date_of_birth        | date   | null: false |



### Association
has_many :items
has_many :buys


## itemsテーブル

| Column             | Type       | Options     |
|--------------------|------------|-------------|
| user               | references | null: false foreign_key: true |
| items_name         | string     | null: false |
| explain            | text       | null: false |
| category_id        | integer    | null: false |
| situation_id       | integer    | null: false |
| delivery_charge_id | integer    | null: false |
| area_id            | integer    | null: false |
| shipping_day_id    | integer    | null: false |
| price              | integer    | null: false |



### Association
belongs_to :user
has_one :buy


## buysテーブル

| Column             | Type       | Options |
|--------------------|------------|---------|
| user               | references | null: false foreign_key: true |
| item               | references | null: false foreign_key: true |



### Association
has_one :address
belongs_to :user
belongs_to :item


## addressesテーブル

| Column             | Type       | Options     |
|--------------------|------------|-------------|
| buy                | references | null: false foreign_key: true |
| postal_code        | string     | null: false |
| area_id            | integer    | null: false |
| city               | string     | null: false |
| address            | string     | null: false |
| building           | string     |             |
| phone_number       | string     | null: false |



### Association
belongs_to :buy