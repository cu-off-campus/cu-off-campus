# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

apartments = [
  {
    name: "Apartment 1",
    price: 1200,
    image: nil,
    description: "This is apartment 1.",
    address: "3 Apple St"
  },
  {
    name: "Apartment 2",
    price: 1500,
    image: "https://i.imgur.com/OweOwKu.jpg",
    description: "This is apartment 2.",
    address: "5 Banana St"
  },
  {
    name: "Apartment 3",
    price: 800,
    image: nil,
    description: "This is apartment 3.",
    address: "7 Coral St"
  },
  {
    name: "Apartment 4",
    price: 800,
    image: nil,
    description: "This is apartment 4.",
    address: "9 Tomato St"
  }
]

users = Array.new(15) do
  {
    username: Faker::Alphanumeric.alpha(number: 5),
    password: "testpassword"
  }
end
users << {
  username: "test",
  password: "test"
}

comments = Array.new(15) do |i|
  {
    user_id: i + 1,
    apartment_id: rand(1..4),
    rating: rand(50..100),
    comment: Faker::Lorem.paragraph,
    tags: Faker::Lorem.words(number: rand(0..4)).join(",")
  }
end

users.each do |user|
  u = User.new(**user, password_confirmation: 'nomatch')
  u.email = "#{user[:username]}@columbia.edu"
  u.password_confirmation = user[:password]
  u.save
end

apartments.each do |ap|
  Apartment.create!(ap)
end

comments.each do |comment|
  Comment.create!(comment)
end
