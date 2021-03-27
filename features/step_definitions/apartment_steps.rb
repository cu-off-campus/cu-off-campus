Given /the following apartment data exist/ do |apartment_table|
  apartment_table.hashes.each do |apartment|
    Apartment.create(apartment)
  end
end

Then /(.*) seed apartments should exist/ do |n_seeds|
  expect(Apartment.count).to be n_seeds.to_i
end
