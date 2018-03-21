FactoryGirl.define do
  factory :product do |f|
    f.image {Faker::Avatar.image}
    f.name {Faker::Food.dish}
    f.price {rand(20..200)}
    f.size {rand(10..50)}
    f.color {Faker::Color.color_name}
    f.discount {rand(10..30)}
    f.description {Faker::Lorem.paragraphs}
    f.quantity_product_available {rand(10..30)}
    f.discount_customer_available {rand(10..30)}
    f.rate {rand(1..5)}
  end
end
