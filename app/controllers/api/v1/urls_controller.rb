module Api
  module V1
    class UrlsController < ApiController
      respond_to :json

      def index
        @urls = Url.all
      end
    end
  end
end
