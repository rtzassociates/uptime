module Api
  module V1
    class ApiController < ApplicationController
      skip_filter :login_required
      skip_filter :authorize
      http_basic_authenticate_with name: ENV['MY_API_KEY'], password: ENV['MY_API_PASS']
    end
  end
end
