Given /the following apartment data exist/ do |apartment_table|
  apartment_table.hashes.each do |apartment|
    Apartment.create(apartment)
  end
end

Then /(.*) seed apartments should exist/ do |n_seeds|
  expect(Apartment.count).to be n_seeds.to_i
end

Then /the order is as follows/ do |ordering|
  e1 = nil
  ordering.rows.each do |value|
    expect(/#{e1}.*#{value}/m =~ page.body).to be_truthy
    e1 = value
  end
end
