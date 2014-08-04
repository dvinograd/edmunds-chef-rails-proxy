require 'edmunds-chef-rails-proxy/common'

class CookbooksController < ApplicationController
  # GET /cookbooks
  def index
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # GET /cookbooks/:id
  def show
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # POST /cookbooks
  def create
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # PUT /cookbooks/:id
  def update
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # DELETE /cookbooks/:id
  def destroy
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end
end
