Rails.application.routes.draw do
  root 'top#index'
  resources :users, only: [:show, :new, :create]
  resources :sessions, only: [:new, :create, :destroy]
end
