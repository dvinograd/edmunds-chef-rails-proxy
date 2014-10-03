require 'edmunds-chef-rails-proxy/common'

def filter2(hsh, *keys)
  hsh.reject { |k, _| keys.include? k }
end

class SearchController < ApplicationController
  # GET /search
  def index
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # GET /search/:id
  def show
    result = process_request(request)
    json_body = JSON.parse(result["body"])
    if json_body["rows"]
      json_body["rows"].each do |row|
        ["automatic","default","normal","override"].each do |top_attr|
          if request.params["include-attrs"]
            row[top_attr].delete_if {|k,v| !request.params["include-attrs"].split(",").include? k}
          else
            row.delete_if {|k,v| k == top_attr}
          end
        end
      end
    end
    render :json => JSON.pretty_generate(json_body), :status => result["status"]
  end

  # POST /search
  def create
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end
end
