require 'edmunds-chef-rails-proxy/common'

class RolesController < ApplicationController
  # GET /roles
  def index
    process_request(request)
  end

  # GET /roles/:id
  def show
    process_request(request)
  end

  # POST /roles
  def create
    process_request(request)
  end

  # PUT /roles/:id
  def update
    process_request(request)
  end

  # DELETE /roles/:id
  def destroy
    process_request(request)
  end
end
