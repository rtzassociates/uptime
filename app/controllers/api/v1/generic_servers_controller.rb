module Api
  module V1
    class GenericServersController < ApiController
      respond_to :json

      def index
        @generic_servers = GenericServer.public_servers
      end
    end
  end
end
