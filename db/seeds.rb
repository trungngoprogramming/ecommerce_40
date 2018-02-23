User.create!(firstname: "Admin",
  lastname: "Admin",
  birthday: "1/10/1996",
  gender: 1,
  email: "admin@gmail.com",
  phone: 1234567892,
  password: "123123123",
  role: 1)

99.times do |n|
  User.create!(firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    birthday: "1/10/1996",
    gender: rand(1..2),
    email: "example-#{n+1}@gmail.com",
    phone: 1234567892,
    password: "123123123",
    role: 2)
end

50.times do |n|
  ProductGroup.create!(name: "category-#{n+1}",
    content: Faker::Lorem.paragraph,
    image: Faker::Avatar.image,
    parent_id: rand(0..3))
end

100.times do |n|
  Product.create!(name: "item-#{n+1}",
    price: rand(1..500),
    size: rand(1..200),
    color: "red",
    discount: rand(0..50),
    description: Faker::Lorem.paragraph,
    quantity_product_available: rand(0..200),
    discount_customer_available: rand(0..50),
    rate: rand(1..5),
    image: Faker::Avatar.image,
    date_of_entry: "1/10/2018")
end
