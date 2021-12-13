FactoryBot.define do
  factory :soccer_field do
    field_name {Faker::Name.name}
    price {Faker::Commerce.price(range: 10000..100000).to_i}
    description {Faker::Lorem.sentence(word_count: 40)}
    type_field {Faker::Number.between(from: 0, to: 2)}
    status {Faker::Number.between(from: 0, to: 1)}
  end
end
