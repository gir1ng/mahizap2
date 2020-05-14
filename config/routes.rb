Rails.application.routes.draw do
  get "users/new"
  root "mahizap#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :menus
  resources :users
end
