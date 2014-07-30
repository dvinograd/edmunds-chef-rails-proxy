Rails.application.routes.draw do

  resources :cookbooks
  resources :clients
  resources :data
  resources :environments
  resources :roles
  resources :search
  resources :users

end
