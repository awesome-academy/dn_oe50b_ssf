FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.free_email}
    password {"password"}
    password_confirmation {"password"}
    phone {Faker::PhoneNumber.cell_phone.gsub!('-','')}
    role {User.roles[:user]}
    trait "with_account_activated" do
      after(:create) do |user, evaluator|
        user.activate
      end
    end
  end
  factory :admin, class: User do
    name {Faker::Name.name}
    email {Faker::Internet.free_email}
    password {"password"}
    password_confirmation {"password"}
    phone {Faker::PhoneNumber.cell_phone.gsub!('-','')}
    role {User.roles[:admin]}
  end
end
