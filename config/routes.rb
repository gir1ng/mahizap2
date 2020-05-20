Rails.application.routes.draw do
  root "mahizap#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/foods/search", to: "foods#search"
  get "/session_result_delete", to: "meal_records#session_result_delete"
  get "save_point", to: "users#save_point"
  get "graph", to: "tasks#graph"
  resources :foods
  resources :users
  resources :meal_records
  resources :tasks
end
