# frozen_string_literal: true

module Reach
  module Util
    class Configuration
      attr_accessor :username, :auth_token, :http_client, :logger

      def username=(value)
        @username = value
      end

      def auth_token=(value)
        @auth_token = value
      end

      def http_client=(value)
        @http_client = value
      end

      def logger=(value)
        @logger = value
      end
    end
  end
end
