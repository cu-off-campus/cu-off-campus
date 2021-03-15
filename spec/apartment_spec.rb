require 'rails_helper'
require_relative '../app/models/apartment'

describe Apartment do
  describe 'with_price_range' do
    it 'should return the Apartment\'s where clause result by extracting the left/right price bound' do
      range = nil
      expect(Apartment.with_price_range(range)).to eq(Apartment.all)

      range = [nil, nil]
      expect(Apartment.with_price_range(range)).to eq(Apartment.all)

      range = [nil, 2000]
      expect(Apartment.with_price_range(range)).to eq(Apartment.where(price: (0..2000)))

      range = [1500, 2000]
      expect(Apartment.with_price_range(range)).to eq(Apartment.where(price: (1500..2000)))

      range = [1500, nil]
      expect(Apartment.with_price_range(range)).to eq(Apartment.where("price >= ?", 1500))
    end

    it 'should filter Apartment by query, price_range, ordering' do
      query = nil
      price_range = []
      ordering = { rating: :desc }
      expect(Apartment.filter(query, price_range, ordering)).to eq(Apartment.order(ordering))

      query = nil
      price_range = []
      ordering = { price: :desc }
      expect(Apartment.filter(query, price_range, ordering)).to eq(Apartment.order(ordering))

      query = nil
      price_range = []
      ordering = nil
      expect(Apartment.filter(query, price_range, ordering)).to eq(Apartment.order(ordering))

      query = 'o'
      price_range = []
      ordering = { price: :desc }
      expect(Apartment.filter(query, price_range, ordering)).to eq(Apartment.where("(LOWER(address) LIKE ?) OR (LOWER(name) LIKE ?)", '%o%', '%o%').order(ordering))

      query = 'apple'
      price_range = [1000, 1499]
      ordering = { price: :desc }
      expect(Apartment.filter(query, price_range, ordering)).to eq(Apartment.where(price: (1000..1499)).where("(LOWER(address) LIKE ?) OR (LOWER(name) LIKE ?)", '%apple%', '%apple%').order(ordering))
    end
  end
end
