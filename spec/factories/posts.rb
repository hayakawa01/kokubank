FactoryBot.define do
  factory :post do
    class_name {'あまりのあるわり算(3時間目)'}
    detail     {'導入→課題→自己解決→トリオ交流→全体交流→まとめ→問題演習'}
    grade_id   {2}
    subject_id {2}
    unit_id    {2}
    association :user

    after(:build) do |post|
      post.image.attach(io: File.open("app/assets/images/bansyo1.jpg"),filename: "bansyo1.jpg")
    end
  end
end
