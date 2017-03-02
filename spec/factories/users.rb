FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password Faker::Internet.password
    role "user"
  end

  factory :invalid_user, class: "User" do
    email nil
    password nil
  end
end
