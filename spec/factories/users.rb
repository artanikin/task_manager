FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password "pass123"
    role "user"
  end

  factory :invalid_user, class: "User" do
    email nil
    password nil
  end
end
