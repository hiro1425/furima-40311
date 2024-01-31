## usersテーブル

| Column               | Type   | Options     |
|----------------------|--------|-------------|
| nickname             | string | null: false |
| email                | string | null: false unique: true|
| encrypted-password   | string | null: false |
| last-name            | string | null: false |
| first-name           | string | null: false |
| name-kana-last-name  | string | null: false |
| name-kana-first-name | string | null: false |
| date-of-birth        | date   | null: false |



### Association
has_many :items
has_many :buys

## itemsテーブル

| Column             | Type       | Options     |
|--------------------|------------|-------------|
| user               | references | null: false foreign_key: true |
| items-name         | string     | null: false |
| explain            | text       | null: false |
| category           | string     | null: false |
| situation          | string     | null: false |
| delivery-charge    | string     | null: false |
| area               | string     | null: false |
| days               | string     | null: false |
| price              | ini        | null: false |


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

## addressテーブル

| Column             | Type       | Options     |
|--------------------|------------|-------------|
| buy                | references | null: false foreign_key: true |
| postal-code        | string     | null: false |
| prefectures        | string     | null: false |
| city               | string     | null: false |
| addresses          | string     | null: false |
| building           | string     | null: true  |
| phone-number       | string     | null: false |



### Association
belongs_to :buy