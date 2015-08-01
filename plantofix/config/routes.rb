Rails.application.routes.draw do
  root "static#home"
  resources :boards
  resources :teams
  resources :users
  resources :sessions, only: [:new, :destroy, :create]
end
