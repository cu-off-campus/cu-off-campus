Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    u = User.new(**user)
    u.email = "#{user[:username]}@columbia.edu"
    u.save
  end
end

Then /(.*) seed users should exist/ do |n_seeds|
  expect(User.count).to be n_seeds.to_i
end
