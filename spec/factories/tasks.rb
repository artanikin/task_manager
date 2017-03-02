FactoryGirl.define do
  factory :task do
    name Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    user
    state "new"
  end
end
