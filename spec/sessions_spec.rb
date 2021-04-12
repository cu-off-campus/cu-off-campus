require 'rails_helper'
require_relative '../app/controllers/sessions_controller'

RSpec.describe SessionsController, :type => :controller do
  it 'create_session' do
    user = {
      username: "test999",
      password: "test999"
    }
    u = User.new(**user, password_confirmation: 'nomatch')
    u.email = "#{user[:username]}@columbia.edu"
    u.password_confirmation = user[:password]
    u.save

    post :create_session, params: { user: { username: 'test999', password: 'test999' } }
    expect(response).to redirect_to root_path

    post :create_session, params: { user: { username: 'test999', password: 'test2' } }
    expect(response).to redirect_to login_path

    u.destroy
  end

  it 'create_user' do
    user = {
      username: "test999",
      password: "test999"
    }
    u = User.new(**user, password_confirmation: 'nomatch')
    u.email = "#{user[:username]}@columbia.edu"
    u.password_confirmation = user[:password]
    u.save

    post :create_user, params: { user: { username: 'test999', password: 'test999', password_confirmation: 'test999' } }
    expect(response).to redirect_to register_path
    expect(response.inspect.to_s).to include "User with this username already exists."

    u.destroy

    post :create_user, params: { user: { username: 'test999', password: 'test999', password_confirmation: 'test999' } }
    expect(response).to redirect_to root_path

    User.where(username: "test999").destroy_all

    post :create_user, params: { user: { username: 'test9999', password: 'test9999', password_confirmation: 'test2' } }
    expect(response).to redirect_to register_path
    expect(response.inspect.to_s).to include "Password does not match."
  end

  it 'delete_session' do
    user = {
      username: "test999",
      password: "test999"
    }
    u = User.new(**user, password_confirmation: 'nomatch')
    u.email = "#{user[:username]}@columbia.edu"
    u.password_confirmation = user[:password]
    u.save

    post :delete_session
    expect(response).to redirect_to apartments_path

    u.destroy
  end

end