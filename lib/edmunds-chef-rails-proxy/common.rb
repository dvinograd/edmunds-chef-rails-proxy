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
        user_key_file = "#{EdmundsChefRailsProxy::Application.config.client_keys_dir}/#{username}.pem"
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

# Sign a request using mixlib-authentication and client key
def sign_request(request, client_name, client_key)
    return request
end

# Forward a request to Chef server, and return response
def forward_request(request)
    case request.method
        when "GET"
            req = Net::HTTP::Get.new(request.fullpath)
        when "POST"
            req = Net::HTTP::Post.new(request.fullpath)
            req.body = request.body.string
        when "PUT"
            req = Net::HTTP::Put.new(request.fullpath)
            req.body = request.body.string
        when "DELETE"
            req = Net::HTTP::Delete.new(request.fullpath)
        else
            logger.debug " forward_request: invalid request.method"
            return nil
    end

    logger.debug " forward_request: req.body: #{req.body}"

    headers_list = ["Content-Type", "Content-Length", "X-Chef-Version", "X-Ops-Sign", "X-Ops-Userid", "X-Ops-Content-Hash", "X-Ops-Timestamp", "X-Remote-Request-Id"]
    (1..9).to_a.each do |key|
        headers_list << "X-Ops-Authorization-#{key}"
    end
    headers_list.each do |header|
        if request.headers[header]
            logger.debug " forward_request: adding header #{header}"
            req[header] = request.headers[header]
        end
    end

    uri = URI.parse(EdmundsChefRailsProxy::Application.config.chef_server_url)
    res = Net::HTTP.start(uri.hostname, uri.port) { |http|
        http.request(req)
    }

    logger.debug " forward_request: {status => #{res.code}, message => #{res.message}, body => #{res.body}"
    return {"status" => res.code, "message" => res.message, "body" => res.body}
end
