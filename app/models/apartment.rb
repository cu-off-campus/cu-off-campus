# The apartment model
class Apartment < ActiveRecord::Base
    fuzzily_searchable :name
    fuzzily_searchable :address #Enable fuzzy search, MyStuff.find_by_fuzzy_name('Some Name', :limit => 10)
end
