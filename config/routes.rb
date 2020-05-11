Rails.application.routes.draw do
  resources :menus
  # get "menus/new", to: "menus#new"
  root "mahizap#index"
end
