Rails.application.routes.draw do

  # Chef Proxy: resources
  resources :proxy_users

  # Chef Proxy: API
  namespace :api do
    namespace :v1 do
      resources :cookbooks
      resources :environments
      resources :roles
      resources :nodes
      resources :proxy_users
      resources :users
    end
  end

  # Chef: pass-thru API
  resources :cookbooks
  get "/cookbooks/:cookbook_id", :cookbook_id => /[\w\.]+/, :to => "cookbooks#cb_versions"
  get "/cookbooks/:cookbook_id/:cb_version", :cb_version => /[\w\.]+/, :to => "cookbooks#show", :as => :cookbook_version
  resources :clients, :id => /[^\/]+/
  resources :data
  resources :environments
  resources :nodes, :id => /[^\/]+/
  resources :roles
  resources :searches, :path => "search", :controller => "search", :only => [:index, :show]
  resources :users

  # Chef Proxy: UI
  root 'application#index'
  get '*path' => 'application#index'

end
