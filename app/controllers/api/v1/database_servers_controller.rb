module Api
  module V1
    class DatabaseServersController < ApiController
      respond_to :json

      def index
        @database_servers = DatabaseServer.public_servers
      end
    end
  end
end
