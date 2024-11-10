FactoryBot.define do
  factory :task do
    association :area
    sequence(:title) { |n| "Task #{n}" }
    description { Faker::Lorem.sentence }
    type { ['important', 'urgent'].sample }
    for_today { false }
    completed { false }
  end
end 