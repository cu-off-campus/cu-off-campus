require 'rails_helper'
require_relative '../app/controllers/comments_controller'

RSpec.describe CommentsController, :type => :controller do
  it 'does new' do
    ap = {
      name: "Apartment 999",
      price: 1200,
      image: nil,
      description: "This is apartment 999.",
      address: "3 Apple St"
    }
    Apartment.create!(ap)
    apartment_id = Apartment.find_by(ap)[:id]

    get :new, params: { apartment_id: apartment_id }
    expect(response).to redirect_to apartment_url(apartment_id)
    expect(response.inspect.to_s).to include "You must be signed in to write a comment."

    get :new, params: { apartment_id: apartment_id }, session: { user_id: 1 }
    expect(response).to have_http_status(200)

    Apartment.destroy(apartment_id)
  end

  it 'does create' do
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

    post :create, params: { comment:
                              { rating: '50',
                                comment: 'dummy',
                                apartment_id: apartment_id,
                                user_id: u.id } }
    expect(response).to redirect_to apartment_url(apartment_id)
    expect(response.inspect.to_s).to include "Failed to comment."

    ap = {
      name: "Apartment 999",
      price: 1200,
      image: nil,
      description: "This is apartment 999.",
      address: "3 Apple St"
    }
    Apartment.create!(ap)
    apartment_id = Apartment.find_by(ap)[:id]

    post :create, params: { comment:
                              { rating: '50',
                                comment: 'dummy' * 50,
                                apartment_id: apartment_id,
                                user_id: u.id } }
    expect(response).to redirect_to apartment_path(apartment_id)
    expect(response.inspect.to_s).to include "Commented successfully."

    Comment.where({ rating: '50',
                    comment: 'dummy' * 50,
                    apartment_id: apartment_id,
                    user_id: u.id }).destroy_all
    Apartment.destroy(apartment_id)
    u.destroy
  end

  it 'does edit' do
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

    get :edit, params: { id: comment_id, apartment_id: apartment_id }
    expect(response).to redirect_to apartment_url(apartment_id)
    expect(response.inspect.to_s).to include "Cannot edit a comment that is not yours."

    get :edit, params: { id: comment_id, apartment_id: apartment_id }, session: { user_id: u.id }
    expect(response).to have_http_status(200)

    Comment.destroy(comment_id)
    u.destroy
    Apartment.destroy(apartment_id)
  end

  it 'does update' do
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

    put :update, params: { id: comment_id,
                           apartment_id: apartment_id,
                           comment:
                             { rating: '50',
                               comment: 'dummy',
                               apartment_id: apartment_id,
                               user_id: u.id } }
    expect(response).to redirect_to apartment_url(apartment_id)
    expect(response.inspect.to_s).to include "Failed to edit your comment."

    put :update, params: { id: comment_id,
                           apartment_id: apartment_id,
                           comment:
                             { rating: '50',
                               comment: 'dummy' * 50,
                               apartment_id: apartment_id,
                               user_id: u.id } }
    expect(response).to redirect_to apartment_url(apartment_id)
    expect(response.inspect.to_s).to include "Your comment was successfully updated."

    Comment.find(comment_id).destroy
    u.destroy
    Apartment.destroy(apartment_id)
  end

  it 'does destroy' do
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

    delete :destroy, params: { id: comment_id }
    expect(response).to redirect_to apartment_url(apartment_id)
    expect(response.inspect.to_s).to include "Cannot delete the comment."

    delete :destroy, params: { id: comment_id }, session: { user_id: u.id }
    expect(response).to redirect_to apartment_url(apartment_id)
    expect(response.inspect.to_s).to include "Successfully deleted the comment."

    u.destroy
    Apartment.destroy(apartment_id)
  end
end