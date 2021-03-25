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
  end

  it 'create_user' do
    post :create_user, params: { user: { username: 'test', password: 'test', password_confirmation: 'test' } }
    expect(response).to redirect_to root_path

    post :create_user, params: { user: { username: 'test', password: 'test', password_confirmation: 'test2' } }
    expect(response).to redirect_to register_path
  end

  it 'delete_session' do
    post :delete_session
    expect(response).to redirect_to root_url
  end
end