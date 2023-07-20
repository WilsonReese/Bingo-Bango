Rails.application.routes.draw do
  resources :reservations
  resources :theaters
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "reservations#index"
end
