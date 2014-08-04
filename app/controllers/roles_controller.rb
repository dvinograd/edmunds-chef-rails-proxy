require 'edmunds-chef-rails-proxy/common'

class RolesController < ApplicationController
  # GET /roles
  def index
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # GET /roles/:id
  def show
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # POST /roles
  def create
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # PUT /roles/:id
  def update
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # DELETE /roles/:id
  def destroy
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end
end
