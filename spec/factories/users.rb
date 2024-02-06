FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              { Faker::Name.initials }
    email                 { Faker::Internet.email }
    password              { 'f7' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    name_kana_last_name   { person.last.katakana }
    name_kana_first_name  { person.first.katakana }
    date_of_birth         { Faker::Date.backward }
  end
end
