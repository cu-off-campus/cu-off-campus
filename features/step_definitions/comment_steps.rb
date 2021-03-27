Given /the following comments exist/ do |comment_table|
  comment_table.hashes.each do |comment|
    Comment.create(comment)
  end
end

Then /(.*) seed comments should exist/ do |n_seeds|
  expect(Comment.count).to be n_seeds.to_i
end
