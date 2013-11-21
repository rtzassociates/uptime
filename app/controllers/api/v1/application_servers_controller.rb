module Api
  module V1
    class ApplicationServersController < ApplicationController
      respond_to :json

      def index
        @application_servers = ApplicationServer.public_servers
      end
    end
  end
end