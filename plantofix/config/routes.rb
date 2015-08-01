Rails.application.routes.draw do
  resources :tasks
  resources :lists
  root "static#home"
  resources :boards
  resources :teams
  resources :users
  resources :sessions, only: [:new, :destroy, :create]
end
