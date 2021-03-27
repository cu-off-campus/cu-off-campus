Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    u = User.new(**user)
    u.email = "#{user[:username]}@columbia.edu"
    u.save
  end
end

Then /(.*) seed users? should exist/ do |n_seeds|
  expect(User.count).to be n_seeds.to_i
end

Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |username, password|
  visit("/login")
  fill_in("Email", with: username)
  fill_in("Password", with: password)
  click_button("Submit")
end
