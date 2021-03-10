# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  { username: "Calendars",                              password: "alphagov/calendars" },
  { username: "Content store",                          password: "alphagov/content-store" },
  { username: "Feedback",                               password: "alphagov/feedback" },
  { username: "Frontend",                               password: "alphagov/frontend" },
  { username: "Imminence",                              password: "alphagov/imminence" },
  { username: "Licence finder",                         password: "alphagov/licence-finder" },
  { username: "Licensify",                              password: "alphagov/licensify" },
  { username: "Publisher",                              password: "alphagov/publisher" },
  { username: "Rummager",                               password: "alphagov/rummager" },
  { username: "Signon",                                 password: "alphagov/signon" },
  { username: "Smart answers",                          password: "alphagov/smart-answers"},
  { username: "Static",                                 password: "alphagov/static" },
  { username: "Support",                                password: "alphagov/support" },
  { username: "Whitehall",                              password: "alphagov/whitehall" },
  { username: "Data insight non-govuk reach collector", password: "alphagov/datainsight-nongovuk-reach-collector"},
]

users.each do |user|
  User.create!(user)
end
