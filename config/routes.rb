Rails.application.routes.draw do
  resources :apartments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: redirect("/apartments")
end
