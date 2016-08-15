Rails.application.routes.draw do
  root 'top#index'
  resources :users, except: [:new, :destroy]
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end
