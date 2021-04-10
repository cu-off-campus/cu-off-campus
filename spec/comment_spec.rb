require 'rails_helper'
require_relative '../app/models/comment'
require 'faker'

describe Comment do
  describe 'self.rating_of' do
    it 'does self.rating_of' do
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

      comment = {
        user_id: User.find_by_username("test999").id,
        apartment_id: apartment_id,
        rating: rand(50..100),
        comment: 'My comment'
      }
      Comment.create!(comment)
      comment_id = Comment.find_by(comment)[:id]

      expect(Comment.rating_of(apartment_id)).to eq(Comment.where(apartment_id: apartment_id).average(:rating))

      Comment.destroy(comment_id)
      u.destroy
      Apartment.destroy(apartment_id)
    end
  end

  describe 'apartment' do
    it 'does apartment' do
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

      comment = {
        user_id: User.find_by_username("test999").id,
        apartment_id: apartment_id,
        rating: rand(50..100),
        comment: 'My comment'
      }
      Comment.create!(comment)
      comment_id = Comment.find_by(comment)[:id]

      comment_1 = Comment.find(comment_id)
      apartment_id = comment_1.apartment_id
      expect(comment_1.apartment).to eq(Apartment.find(apartment_id))

      Comment.destroy(comment_id)
      u.destroy
      Apartment.destroy(apartment_id)
    end
  end

  describe 'user' do
    it 'does user' do
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

      comment = {
        user_id: User.find_by_username("test999").id,
        apartment_id: apartment_id,
        rating: rand(50..100),
        comment: 'My comment'
      }
      Comment.create!(comment)
      comment_id = Comment.find_by(comment)[:id]

      comment_2 = Comment.find(comment_id)
      user_id = comment_2.user_id
      expect(comment_2.user).to eq(User.find(user_id))

      Comment.destroy(comment_id)
      u.destroy
      Apartment.destroy(apartment_id)
    end
  end

  describe 'tags_array' do
    it 'does tags_array' do
      comment = Comment.find_by_tags('vel,odit,ratione')
      expect(comment.tags_array).to eq(['vel', 'odit', 'ratione'])
    end
  end
end
