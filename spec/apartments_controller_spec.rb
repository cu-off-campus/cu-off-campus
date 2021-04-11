require 'rails_helper'
require_relative '../app/controllers/apartments_controller'
require_relative '../app/helpers/application_helper'

RSpec.describe ApartmentsController, :type => :controller do
  # Include for to test current_user in application_helper.rb
  include ApplicationHelper

  it 'does index' do
    get :index, params: { commit: nil }
    expect(response).to redirect_to apartments_path

    get :index, params: { search: "Apple", sort: "price", price: "1000-1499" }, session: { sort: "price", price: "1000-1499" }
    expect(response.inspect.to_s).to include "Apple"

    get :index, params: { search: "Apple", sort: "price", price: "1000-1499" }, session: { search: "Apple", sort: "price", price: "1000-1499" }
    expect(response.inspect.to_s).to include "Apple"

    get :index, params: { search: "Apple", sort: "rating", price: "1000-1499" }, session: { sort: "rating", price: "1000-1499" }
    expect(response.inspect.to_s).to include "Apple"
  end

  it 'does show' do
    ap = {
      name: "Apartment 999",
      price: 1200,
      image: "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
      description: "This is apartment 999.",
      address: "3 Apple St"
    }
    Apartment.create!(ap)
    id = Apartment.find_by(ap)[:id]
    get :show, params: { id: id }
    expect(response.inspect.to_s).to include "Apartment 999"

    Apartment.destroy(id)
  end

  it 'does create' do
    post :create, params: {
      apartment: {
        name: "Apartment 9999",
        price: 800,
        image: nil,
        description: "This is apartment 9999.",
        address: "9 Tomato St"
      }
    }
    expect(response).to redirect_to apartments_path

    post :create, params: {
      apartment: {
        name: "Apartment 9999",
        price: "Invalid price",
        image: nil,
        description: "This is apartment 9999.",
        address: "9 Tomato St"
      }
    }
    expect(response).to redirect_to new_apartment_path

    # Image test
    file = fixture_file_upload("./public/mytest.jpg", "image/jpeg")
    post :create, params: {
      apartment: {
        name: "Apartment 9999",
        price: 800,
        image: file,
        description: "This is apartment 9999.",
        address: "9 Tomato St"
      }
    }
    expect(response).to redirect_to apartments_path
  end

  it 'does edit' do
    ap = {
      name: "Apartment 999",
      price: 1200,
      image: "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
      description: "This is apartment 999.",
      address: "3 Apple St"
    }
    Apartment.create!(ap)
    id = Apartment.find_by(ap)[:id]
    get :edit, params: { id: id }
    expect(response.inspect.to_s).to include "Apartment 999"

    Apartment.destroy(id)
  end

  it 'does update' do
    ap = {
      name: "Apartment 999",
      price: 1200,
      image: nil,
      description: "This is apartment 999.",
      address: "3 Apple St"
    }

    Apartment.create!(ap)
    id = Apartment.find_by(ap)[:id]

    put :update, params: { id: id, apartment: ap }
    expect(response).to redirect_to apartment_path(Apartment.find id)

    Apartment.destroy(id)

    ap = {
      name: "Apartment 999",
      price: 1200,
      image: nil,
      description: "This is apartment 999.",
      address: "3 Apple St"
    }
    Apartment.create!(ap)
    id = Apartment.find_by(ap)[:id]
    ap = {
      name: "Apartment 999",
      price: "Invalid price",
      image: nil,
      description: "This is apartment 999.",
      address: "3 Apple St"
    }
    put :update, params: { id: id, apartment: ap }
    expect(response).to redirect_to edit_apartment_path(Apartment.find id)

    Apartment.destroy(id)

    # Image test
    ap = {
      name: "Apartment 999",
      price: 1200,
      image: nil,
      description: "This is apartment 999.",
      address: "3 Apple St"
    }

    Apartment.create!(ap)
    id = Apartment.find_by(ap)[:id]

    ap = {
      name: "Apartment 999",
      price: 1200,
      image: fixture_file_upload("./public/mytest.jpg", "image/jpeg"),
      description: "This is apartment 999.",
      address: "3 Apple St"
    }

    put :update, params: { id: id, apartment: ap }
    expect(response).to redirect_to apartment_path(Apartment.find id)

    Apartment.destroy(id)
  end

  # https://stackoverflow.com/questions/30462215/setting-a-session-value-through-rspec
  it 'tests current_user in application_helper.rb' do
    user = {
      username: "test999",
      password: "test999"
    }

    u = User.new(**user, password_confirmation: 'nomatch')
    u.email = "#{user[:username]}@columbia.edu"
    u.password_confirmation = user[:password]
    u.save

    get :index, params: { commit: nil }, session: { user_id: u.id }
    expect(current_user).to eq(User.find(u.id))

    u.destroy
  end
end
