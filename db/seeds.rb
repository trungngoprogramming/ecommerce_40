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
