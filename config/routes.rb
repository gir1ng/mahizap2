Rails.application.routes.draw do
  root "mahizap#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/secret_login", to: "sessions#show_secret_login_form"
  post "/secret_login", to: "sessions#secret_login"
  get "/create_secret_password", to: "sessions#show_secret_password_form"
  post "/create_secret_password", to: "sessions#create_secret_password"
  delete "/logout", to: "sessions#destroy"
  get "/foods/search", to: "foods#search"
  get "/session_result_delete", to: "meal_records#session_result_delete"
  get "save_point", to: "users#save_point"
  get "graph", to: "tasks#graph"
  resources :foods
  resources :users
  resources :meal_records
  resources :tasks
  resources :wish_lists
  resources :secrets
end
