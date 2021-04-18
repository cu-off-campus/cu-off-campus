Rails.application.routes.draw do
  resources :apartments, except: :destroy
  resources :comments, except: %i[index show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'application#index'

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create_session'
  post '/logout', to: 'sessions#delete_session'
  get '/register', to: 'sessions#register'
  post '/register', to: 'sessions#create_user'

end
