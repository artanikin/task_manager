FactoryGirl.define do
  factory :task do
    name "MyString"
    description "MyText"
    user
    state "new"
  end
end
