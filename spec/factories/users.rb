# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    email "anupvarghese@outlook.com"
    password "MyPassword"
    password_confirmation "MyPassword"
  end
end
