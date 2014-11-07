Rails.application.routes.draw do

  # Chef proxy resources
  resources :proxy_users

  # Chef pass-thru resources
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

end
