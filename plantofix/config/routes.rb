Rails.application.routes.draw do
  root "static#home"
  resources :users
  resources :teams
  resources :boards
  resources :lists
  resources :tasks
  resources :sessions, only: [:new, :destroy, :create]
  delete "/logout", to: "sessions#destroy"
  delete "/team_member", to: "teams#team_member_destroy"
  post "/team_member", to: "teams#team_member_add"
end
