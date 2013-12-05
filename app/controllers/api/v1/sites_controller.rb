module Api
  module V1
    class SitesController < ApiController
      respond_to :json

      def index
        @sites = Site.with_urls
      end
      
    end
  end
end
