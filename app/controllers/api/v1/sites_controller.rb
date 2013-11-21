module Api
  module V1
    class SitesController < ApplicationController
      respond_to :json

      def index
        @sites = Site.with_urls
      end
      
    end
  end
end