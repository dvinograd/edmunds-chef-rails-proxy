require 'edmunds-chef-rails-proxy/common'

class NodesController < ApplicationController
  # GET /nodes
  def index
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # GET /nodes/:id
  def show
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # POST /nodes
  def create
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # PUT /nodes/:id
  def update
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # DELETE /nodes/:id
  def destroy
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end
end
