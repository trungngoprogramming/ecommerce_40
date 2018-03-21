FactoryGirl.define do
  factory :user do |f|
    f.firstname {Faker::Name.first_name}
    f.lastname {Faker::Name.last_name}
    f.birthday {Faker::Date.birthday(16, 65)}
    f.gender {rand(1..2)}
    f.address1 {Faker::Address.street_address}
    f.address2 {Faker::Address.secondary_address}
    f.city {Faker::Address.city}
    f.state {Faker::Address.state}
    f.country {Faker::Address.country}
    f.phone {1234567892}
    f.company {Faker::Company.name}
    f.email {Faker::Internet.email}
    f.password {"123123123"}
    f.role {1}
  end
end
