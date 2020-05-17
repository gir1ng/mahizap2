Rails.application.routes.draw do
  root "mahizap#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/foods/search", to: "foods#search"
  get "/session_result_delete", to: "meal_records#session_result_delete"
  resources :foods
  resources :users
  resources :meal_records
end
