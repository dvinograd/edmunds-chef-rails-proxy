require 'edmunds-chef-rails-proxy/common'

class RolesController < ApplicationController
  def my_process_request(request)
    if verify_signed_request(request)
        result = forward_request(request)
        render json: result["body"], :status => result["status"]
    else
      render json: {"error" => "Proxy could not verify signed request"}, :status => 401
    end
  end

  # GET /roles, POST /roles
  def index
    my_process_request(request)
  end

  # GET /roles/:id
  def show
    my_process_request(request)
  end

  # POST /roles
  def create
    my_process_request(request)
  end

  # PUT /roles/:id
  def update
    my_process_request(request)
  end

  # DELETE /roles/:id
  def destroy
    my_process_request(request)
  end
end
