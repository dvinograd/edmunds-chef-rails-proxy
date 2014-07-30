require 'edmunds-chef-rails-proxy/common'

class SearchController < ApplicationController
  # GET /search
  def index
    process_request(request)
  end

  # GET /search/:id
  def show
    process_request(request)
  end

  # POST /search
  def create
    process_request(request)
  end
end
