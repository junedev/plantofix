Rails.application.routes.draw do
  root "static#home"
  resources :users, except: [:index, :edit]
  resources :teams, only: [:create, :update, :destroy]
  resources :boards, except: [:new, :edit]
  resources :lists, only: [:create, :update, :destroy]
  resources :tasks, only: [:create, :update, :destroy]
  resources :sessions, only: [:new, :destroy, :create]
  delete "/logout", to: "sessions#destroy"
  delete "/team_member", to: "teams#team_member_destroy"
  post "/team_member", to: "teams#team_member_add"
end
