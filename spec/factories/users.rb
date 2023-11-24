FactoryBot.define do
  sequence :name do |n|
    "User #{n}"
  end

  factory :user do
    name
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { 'admin' }
  end
end
