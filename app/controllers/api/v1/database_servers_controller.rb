module Api
  module V1
    class DatabaseServersController < ApplicationController
      respond_to :json

      def index
        @database_servers = DatabaseServer.public_servers
      end
    end
  end
end