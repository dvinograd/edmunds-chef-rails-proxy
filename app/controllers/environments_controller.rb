require 'edmunds-chef-rails-proxy/common'

class EnvironmentsController < ApplicationController
  # GET /environments
  def index
    process_request(request)
  end

  # GET /environments/:id
  def show
    process_request(request)
  end

  # POST /environments
  def create
    process_request(request)
  end

  # PUT /environments/:id
  def update
    process_request(request)
  end

  # DELETE /environments/:id
  def destroy
    process_request(request)
  end
end
