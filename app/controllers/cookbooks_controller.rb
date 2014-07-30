require 'edmunds-chef-rails-proxy/common'

class CookbooksController < ApplicationController
  # GET /cookbooks
  def index
    process_request(request)
  end

  # GET /cookbooks/:id
  def show
    process_request(request)
  end

  # POST /cookbooks
  def create
    process_request(request)
  end

  # PUT /cookbooks/:id
  def update
    process_request(request)
  end

  # DELETE /cookbooks/:id
  def destroy
    process_request(request)
  end
end
