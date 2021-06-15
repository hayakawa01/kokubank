FactoryBot.define do
  factory :comment do
    text {'あああ'}
    association :user
    association :post
  end
end
