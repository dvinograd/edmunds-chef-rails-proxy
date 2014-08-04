# Configuration

EdmundsChefRailsProxy::Application.config.client_keys_dir = "/etc/edmunds-chef-rails-proxy/keys/users"
EdmundsChefRailsProxy::Application.config.client_name = "proxyrw"
EdmundsChefRailsProxy::Application.config.client_key = "/etc/edmunds-chef-rails-proxy/keys/proxyrw.pem"

EdmundsChefRailsProxy::Application.config.chef_server_url = "http://chef11-preprod.vip.edmunds.com:80"

EdmundsChefRailsProxy::Application.config.anon_requests = [
    {:method => "GET", :path => "/roles"}, 
    {:method => "GET", :path => "/roles/.*"}, 
    {:method => "GET", :path => "/environments"},
    {:method => "GET", :path => "/environments/.*"},
    {:method => "GET", :path => "/cookbooks"},
    {:method => "GET", :path => "/cookbooks/.*"} ]
