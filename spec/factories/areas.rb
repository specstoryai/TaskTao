FactoryBot.define do
  factory :area do
    sequence(:title) { |n| "Area #{n}" }
    description { Faker::Lorem.sentence }
    color { "##{Faker::Color.hex_color}" }
    active { true }
  end
end 