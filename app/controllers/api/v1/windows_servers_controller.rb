module Api
  module V1
    class WindowsServersController < ApplicationController
      respond_to :json

      def index
        @windows_servers = WindowsServer.public_servers
      end
    end
  end
end