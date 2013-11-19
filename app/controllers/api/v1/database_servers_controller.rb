module Api
  module V1
    class DatbaseServersController < ApplicationController
      respond_to :json

      def index
        @database_servers = DatabaseServer.all
      end
    end
  end
end