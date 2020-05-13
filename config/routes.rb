Rails.application.routes.draw do
  get 'users/new'
  resources :menus
  # get "menus/new", to: "menus#new"
  root "mahizap#index"
end
