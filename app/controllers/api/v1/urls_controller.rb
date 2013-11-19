module Api
  module V1
    class UrlsController < ApplicationController
      respond_to :json

      def index
        @urls = Url.all
      end
    end
  end
end