FactoryBot.define do
  factory :post do
    class_name {'あまりのあるわり算(3時間目)'}
    detail     {'導入→課題→自己解決→トリオ交流→全体交流→まとめ→問題演習'}
    association :user

    after(:build) do |post|
      post.image.attach(io: File.open("app/assets/images/bansyo1.jpg"),filename: "bansyo1.jpg")

      parent_grade = create(:grade)
      child_grade = parent_grade.children.create(name:"国語")
      grand_child_grade = child_grade.children.create(name:"説明文")

      post.grade_id = grand_child_grade.id
    end
  end
end
