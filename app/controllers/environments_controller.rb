require 'edmunds-chef-rails-proxy/common'

class EnvironmentsController < ApplicationController
  # GET /environments
  def index
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # GET /environments/:id
  def show
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # POST /environments
  def create
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # PUT /environments/:id
  def update
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end

  # DELETE /environments/:id
  def destroy
    result = process_request(request)
    render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
  end
end
