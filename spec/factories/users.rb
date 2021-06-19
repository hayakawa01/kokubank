FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { "000aaa" }
    password_confirmation { password }
    family_name { "山田" }
    first_name { "太郎" }
    family_name_kana { "ヤマダ" }
    first_name_kana { "タロウ" }
    prefecture_id { 2 }
    career_id { 2 }
    favorite_subject_id { 2 }
    introduction { "初任者です。先生方の黒板を参考に授業をしていければいいなと思います" }
  end
end
