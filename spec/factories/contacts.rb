FactoryGirl.define do
  factory :contact do
    name      { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone     { Faker::PhoneNumber.cell_phone.gsub(/[^0-9]/, '') }

    association(:user)

  end
end
