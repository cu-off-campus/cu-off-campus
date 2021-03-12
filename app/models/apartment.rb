class Apartment < ActiveRecord::Base
    def self.fuzzy_search(address, name)
        where("address LIKE ?", address).
        where("name LIKE ?", name)
    end
end
