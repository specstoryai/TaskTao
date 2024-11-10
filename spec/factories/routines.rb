FactoryBot.define do
  factory :routine do
    sequence(:title) { |n| "Routine #{n}" }
    description { Faker::Lorem.sentence }
    frequency { ['daily', 'weekly', 'monthly', 'quarterly', 'yearly'].sample }
    active { true }
    completed { false }
  end
end 