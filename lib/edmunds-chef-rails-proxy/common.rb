# Common functions for proxy

require 'mixlib/authentication/http_authentication_request'
require 'mixlib/authentication/signatureverification'
require 'mixlib/authentication/signedheaderauth'
require 'openssl'

require 'net/http'
require 'net/https'
require 'uri'

# Verify signed request using mixlib-authentication
def verify_signed_request(request)

    begin
        authenticator = Mixlib::Authentication::SignatureVerification.new(request)
        username = authenticator.user_id
        user_key_file = "#{EdmundsChefRailsProxy::Application.config.user_keys_dir}/#{username}.pem"
        user_key = OpenSSL::PKey::RSA.new( ::File.read( user_key_file ) )
        authenticator.authenticate_request(user_key)

    rescue Mixlib::Authentication::MissingAuthenticationHeader => e
        logger.debug " verify_signed_request: MissingAuthenticationHeader"
        logger.debug "Authentication failed: #{e.class.name}: #{e.message}"
        #logger.debug "#{e.backtrace.join("\n")}"
        return false

    rescue StandardError => se
        logger.debug " verify_signed_request: StandardError"
        logger.debug "Authentication failed: #{se}"
        #logger.debug "#{se.backtrace.join("\n")}"
        return false

    end

    logger.debug " verify_signed_request: OK"
    return true

end

# Sign a request using mixlib-authentication and client key file
def sign_request(request, client_name, client_key_file)

    client_key = OpenSSL::PKey::RSA.new( ::File.read( client_key_file ) )
    signed_headers = Mixlib::Authentication::SignedHeaderAuth.signing_object(
            :http_method => request.method,
            :body => request.body.read(),
            :host => request.headers["Host"],
            :path => request.fullpath.split("?")[0],    # GET /thing?param=val becomes GET /thing
            :timestamp => Time.now.utc.iso8601,
            :user_id => client_name,
            :file => '',
          ).sign(client_key)

    #logger.debug " sign_request: #{signed_headers}"

    signed_headers.each do |k,v|
        request.headers[k] = v
    end

    return request

end

# Forward a request to Chef server, and return response
def forward_request(chef_server, request)
    
    case request.method
        when "GET"
            req = Net::HTTP::Get.new(request.fullpath)
            logger.debug " forward_request: created GET request with #{request.fullpath}"
        when "POST"
            req = Net::HTTP::Post.new(request.fullpath)
            req.body = request.body.string
            logger.debug " forward_request: created POST request with #{request.fullpath}"
        when "PUT"
            req = Net::HTTP::Put.new(request.fullpath)
            req.body = request.body.string
            logger.debug " forward_request: created PUT request with #{request.fullpath}"
        when "DELETE"
            req = Net::HTTP::Delete.new(request.fullpath)
            logger.debug " forward_request: created DELETE request with #{request.fullpath}"
        else
            logger.warn " forward_request: invalid request.method"
            return nil
    end

    #logger.debug " forward_request: req.body: #{req.body}"

    headers_list = ["Content-Type", "Content-Length", "X-Chef-Version", "X-Ops-Sign", "X-Ops-Userid", "X-Ops-Content-Hash", "X-Ops-Timestamp", "X-Remote-Request-Id"]
    (1..9).to_a.each do |key|
        headers_list << "X-Ops-Authorization-#{key}"
    end
    headers_list.each do |header|
        if request.headers[header]
            #logger.debug " forward_request: adding header #{header}: #{request.headers[header]}"
            req[header] = request.headers[header]
        end
    end

    uri = URI.parse(chef_server[:url])
    res = Net::HTTP.start(uri.hostname, uri.port) { |http|
        http.request(req)
    }

    #logger.debug " forward_request: {status => #{res.code}, message => #{res.message}, body => #{res.body}"
    return {"status" => res.code, "message" => res.message, "body" => res.body}

end

# Decide which Chef server to use
def determine_chef_server(request)
    
    # Return specified Chef server, if given and match found
    if request.params["chef-server"]
        EdmundsChefRailsProxy::Application.config.chef_servers.each do |chef_server|
          if chef_server[:url] =~ /#{request.params["chef-server"]}/
            return chef_server
          end
        end
    end
    
    # Return matching Chef server if environment is specified
    if request.params["chef-environment"] || request.fullpath =~ /\/environments\/.*/
      chef_environment = request.params["chef-environment"] || request.fullpath[/\/environments\/([a-zA-Z0-9-]*).*/, 1]
      logger.debug " determine_chef_server: chef_environment = #{chef_environment}"
      EdmundsChefRailsProxy::Application.config.chef_servers.each do |chef_server|
        logger.debug chef_server
        chef_server[:envs].each do |chef_server_env|
          if chef_environment =~ /#{chef_server_env}/
            return chef_server
          end
        end
      end
    end

    # At this point, return default Chef server
    return EdmundsChefRailsProxy::Application.config.chef_servers[0]

end

# Process a request within controller
def process_request(request)

  chef_server = determine_chef_server(request)
  logger.debug " process_request: chef_server = #{chef_server[:url]}"

  if request.headers["X-Ops-Sign"]
    # process signed request (from knife)
    if verify_signed_request(request)
      result = forward_request( chef_server, sign_request(request, chef_server[:client_name], chef_server[:client_key]) )
      #logger.debug result
      return result
    else
      result = { "body" => {"error" => "Proxy could not process signed request"}, "status" => 401 }
      #logger.debug result
      return result
    end

  else
    # process unsigned request
    EdmundsChefRailsProxy::Application.config.anon_requests.each do |anon_req|
      #logger.debug " process_request: #{request.method} =~ #{anon_req[:method]} && #{request.fullpath} =~ /#{anon_req[:path]}/"
      if request.method =~ /#{anon_req[:method]}/ && request.fullpath =~ /#{anon_req[:path]}/
        result = forward_request( chef_server, sign_request(request, chef_server[:client_name], chef_server[:client_key]) )
        #logger.debug result
        return result
      end
    end
    # at this point, return 401 error
    result = { "body" => {"error" => "Proxy could not process anonymous request"}, "status" => 401 }
    #logger.debug result
    return result

  end

end
