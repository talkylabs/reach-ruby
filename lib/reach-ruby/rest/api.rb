###
#  This code was generated by
#  ___ ___   _   ___ _  _    _____ _   _    _  ___   ___      _   ___ ___      ___   _   ___     ___ ___ _  _ ___ ___    _ _____ ___  ___ 
# | _ \ __| /_\ / __| || |__|_   _/_\ | |  | |/ | \ / / |    /_\ | _ ) __|___ / _ \ /_\ |_ _|__ / __| __| \| | __| _ \  /_\_   _/ _ \| _ \
# |   / _| / _ \ (__| __ |___|| |/ _ \| |__| ' < \ V /| |__ / _ \| _ \__ \___| (_) / _ \ | |___| (_ | _|| .` | _||   / / _ \| || (_) |   /
# |_|_\___/_/ \_\___|_||_|    |_/_/ \_\____|_|\_\ |_| |____/_/ \_\___/___/    \___/_/ \_\___|   \___|___|_|\_|___|_|_\/_/ \_\_| \___/|_|_\
# 
#  NOTE: This class is auto generated by OpenAPI Generator.
#  https://openapi-generator.tech
#  Do not edit the class manually.
#
# frozen_string_literal: true

module Reach
  module REST
    class Api < Domain
      ##
      # Initialize the Api Domain
      def initialize(reach)
        super

        @base_url = 'https://api.reach.talkylabs.com'
        @host = 'api.reach.talkylabs.com'
        @port = 443

        # Versions
        @messaging = nil
        @authentix = nil
      end

      ##
      # Version Messaging
      def messaging
        @messaging ||= Messaging.new self
      end

      ##
      # Version Authentix
      def authentix
        @authentix ||= Authentix.new self
      end      

      ##
      # Provide a user friendly representation
      def to_s
        '#<Reach::REST::Api>'
      end
    end
  end
end
