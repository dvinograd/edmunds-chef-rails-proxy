require 'edmunds-chef-rails-proxy/common'

module Api
  module V1
    class CookbooksController < ApplicationApiController

      def index
        result = process_api_request(request, 'api/v1/')
        render :json => JSON.pretty_generate(result["body"]), :status => result["status"]
      end
    end
  end
end
