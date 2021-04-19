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
      price_range = nil
      expect(Apartment.filter(query, price_range)).to eq(Apartment.with_price_range(price_range))

      query = 'o'
      price_range = nil

      t = Apartment.where("(LOWER(address) LIKE ?) OR (LOWER(name) LIKE ?)", "%o%", "%o%")
      c = Comment.where("(LOWER(comment) LIKE ?) OR (LOWER(tags) LIKE ?)", "%o%", "%o%")
      apartment_id_list = c.pluck(:apartment_id)
      t2 = Apartment.where(id: apartment_id_list)
      ids = t.pluck(:id) + t2.pluck(:id)
      t = Apartment.where(id: ids.uniq)
      expect(Apartment.filter(query, price_range).order("id ASC")).to eq(t.order("id ASC"))

      query = 'apple'
      price_range = [1000, 1499]

      t = Apartment.where("(LOWER(address) LIKE ?) OR (LOWER(name) LIKE ?)", "%apple%", "%apple%")
      c = Comment.where("(LOWER(comment) LIKE ?) OR (LOWER(tags) LIKE ?)", "%apple%", "%apple%")
      apartment_id_list = c.pluck(:apartment_id)
      t2 = Apartment.where(id: apartment_id_list)
      ids = t.pluck(:id) + t2.pluck(:id)
      t = Apartment.where(id: ids.uniq)

      expect(Apartment.filter(query, price_range).order("id ASC").pluck(:id)).to eq(t.where(price: (1000..1499)).order("id ASC").pluck(:id))
    end
  end

  describe 'rating' do
    it 'does rating' do
      user = {
        username: "test999",
        password: "test999"
      }

      u = User.new(**user, password_confirmation: 'nomatch')
      u.email = "#{user[:username]}@columbia.edu"
      u.password_confirmation = user[:password]
      u.save

      ap = {
        name: "Apartment 999",
        price: 1200,
        image: nil,
        description: "This is apartment 999.",
        address: "3 Apple St"
      }
      Apartment.create!(ap)
      apartment_id = Apartment.find_by(ap)[:id]
      apartment = Apartment.find(apartment_id)

      comment = {
        user_id: User.find_by_username("test999").id,
        apartment_id: apartment_id,
        rating: rand(50..100),
        comment: 'My comment'
      }
      Comment.create!(comment)
      comment_id = Comment.find_by(comment)[:id]

      expect(apartment.rating).to eq(Comment.rating_of apartment_id)

      Comment.destroy(comment_id)
      u.destroy
      Apartment.destroy(apartment_id)
    end
  end

  describe 'comments' do
    it 'does comments' do
      user = {
        username: "test999",
        password: "test999"
      }

      u = User.new(**user, password_confirmation: 'nomatch')
      u.email = "#{user[:username]}@columbia.edu"
      u.password_confirmation = user[:password]
      u.save

      ap = {
        name: "Apartment 999",
        price: 1200,
        image: nil,
        description: "This is apartment 999.",
        address: "3 Apple St"
      }
      Apartment.create!(ap)
      apartment_id = Apartment.find_by(ap)[:id]
      apartment = Apartment.find(apartment_id)

      comment = {
        user_id: User.find_by_username("test999").id,
        apartment_id: apartment_id,
        rating: rand(50..100),
        comment: 'My comment'
      }
      Comment.create!(comment)
      comment_id = Comment.find_by(comment)[:id]

      expect(apartment.comments).to eq(Comment.where(apartment_id: apartment_id).order(updated_at: :desc))

      Comment.destroy(comment_id)
      u.destroy
      Apartment.destroy(apartment_id)
    end
  end

  describe 'num_comments' do
    it 'does num_comments' do
      user = {
        username: "test999",
        password: "test999"
      }

      u = User.new(**user, password_confirmation: 'nomatch')
      u.email = "#{user[:username]}@columbia.edu"
      u.password_confirmation = user[:password]
      u.save

      ap = {
        name: "Apartment 999",
        price: 1200,
        image: nil,
        description: "This is apartment 999.",
        address: "3 Apple St"
      }
      Apartment.create!(ap)
      apartment_id = Apartment.find_by(ap)[:id]
      apartment = Apartment.find(apartment_id)

      comment = {
        user_id: User.find_by_username("test999").id,
        apartment_id: apartment_id,
        rating: rand(50..100),
        comment: 'My comment'
      }
      Comment.create!(comment)
      comment_id = Comment.find_by(comment)[:id]

      apartment = Apartment.find_by(ap)
      expect(apartment.num_comments).to eq(apartment.comments.count)

      Comment.destroy(comment_id)
      u.destroy
      Apartment.destroy(apartment_id)
    end
  end
end
