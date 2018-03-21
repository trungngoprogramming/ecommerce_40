FactoryGirl.define do
  factory :cart do |f|
    f.price {200}
    f.quantity {2}
    f.discount {rand(2..30)}
    f.product_name {Faker::Food.dish}
  end
end
