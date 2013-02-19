# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "ahmet#{n}" }
    sequence(:password) { |n| "pisipisi#{n}" }
    password_confirmation { |u| u.password }
  end
end
