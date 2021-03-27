require 'rails_helper'
require_relative '../app/controllers/sessions_controller'

RSpec.describe SessionsController, :type => :controller do
  it 'create_session' do
    user = {
      username: "test",
      password: "test"
    }
    u = User.new(**user, password_confirmation: 'nomatch')
    u.email = "#{user[:username]}@columbia.edu"
    u.password_confirmation = user[:password]
    u.save

    post :create_session, params: { user: { username: 'test', password: 'test' } }
    expect(response).to redirect_to root_path

    post :create_session, params: { user: { username: 'test', password: 'test2' } }
    expect(response).to redirect_to login_path

    u.destroy
  end

  it 'create_user' do
    user = {
      username: "test",
      password: "test"
    }
    u = User.new(**user, password_confirmation: 'nomatch')
    u.email = "#{user[:username]}@columbia.edu"
    u.password_confirmation = user[:password]
    u.save

    post :create_user, params: { user: { username: 'test', password: 'test', password_confirmation: 'test' } }
    expect(response).to redirect_to register_path
    expect(response.inspect.to_s).to include "User with this username already exists."

    User.destroy_all

    post :create_user, params: { user: { username: 'test', password: 'test', password_confirmation: 'test' } }
    expect(response).to redirect_to root_path

    User.destroy_all

    post :create_user, params: { user: { username: 'test', password: 'test', password_confirmation: 'test2' } }
    expect(response).to redirect_to register_path
    expect(response.inspect.to_s).to include "Password does not match."

    User.destroy_all
  end

  it 'delete_session' do
    user = {
      username: "test",
      password: "test"
    }
    u = User.new(**user, password_confirmation: 'nomatch')
    u.email = "#{user[:username]}@columbia.edu"
    u.password_confirmation = user[:password]
    u.save

    post :delete_session
    expect(response).to redirect_to root_url

    u.destroy
  end

end