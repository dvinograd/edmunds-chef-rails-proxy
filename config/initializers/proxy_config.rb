# Configuration

EdmundsChefRailsProxy::Application.config.user_keys_dir = "/etc/edmunds-chef-rails-proxy/keys/users"

EdmundsChefRailsProxy::Application.config.chef_servers = [
    {
        :url => "http://chef11-preprod.vip.edmunds.com:80",
        :client_name => "proxyrw",
        :client_key => "/etc/edmunds-chef-rails-proxy/keys/chef11-preprod_proxyrw.pem",
        :envs => ["dev.*", "qa.*", ".*sandbox"]
    },
    {
        :url => "http://chef11-prod.vip.edmunds.com:80",
        :client_name => "proxyro",
        :client_key => "/etc/edmunds-chef-rails-proxy/keys/chef11-prod_proxyro.pem",
        :envs => ["prod.*"]
    }
]

EdmundsChefRailsProxy::Application.config.anon_requests = [
    {:method => "GET", :path => "/roles"}, 
    {:method => "GET", :path => "/roles/.*"}, 
    {:method => "GET", :path => "/environments"},
    {:method => "GET", :path => "/environments/.*"},
    {:method => "GET", :path => "/cookbooks"},
    {:method => "GET", :path => "/cookbooks/.*"},
    {:method => "GET", :path => "/nodes"},
    {:method => "GET", :path => "/nodes/.*"},
    {:method => "GET", :path => "/search/.*"}
]
