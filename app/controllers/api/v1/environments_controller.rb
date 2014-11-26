require 'edmunds-chef-rails-proxy/common'

module Api
  module V1
    class EnvironmentsController < ApplicationApiController

      def index
        result = process_api_request(request, 'api/v1/')
        if result["status"] == 200
          render :json => JSON.pretty_generate(result["body"]), :status => result["status"]
        else
          render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
        end
      end

      def show
        result = process_api_request(request, 'api/v1/')
        if request.params["format"] == "text"
          render :text => format_data(result["body"], "text"), :status => result["status"]
        else
          render :json => JSON.pretty_generate(JSON.parse(result["body"])), :status => result["status"]
        end
      end

    end
  end
end
