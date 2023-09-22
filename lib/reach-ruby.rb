# frozen_string_literal: true

require 'net/http'
require 'net/https'
require 'cgi'
require 'openssl'
require 'base64'
require 'forwardable'
require 'time'
require 'json'

require 'reach-ruby/version' unless defined?(Reach::VERSION)
require 'rack/reach_webhook_authentication' if defined?(Rack) && defined?(Rack::MediaType)

require 'reach-ruby/security/request_validator'
require 'reach-ruby/util/configuration'

Dir[File.join(__dir__, 'reach-ruby/framework/*.rb')].sort.each do |file|
  require file
end

module Reach
  extend SingleForwardable

  autoload :HTTP, File.join(__dir__, 'reach-ruby', 'http.rb')
  autoload :REST, File.join(__dir__, 'reach-ruby', 'rest.rb')

  def_delegators :configuration, :username, :auth_token, :http_client, :logger

  ##
  # Pre-configure with ApiUser and ApiKey so that you don't need to
  # pass them to various initializers each time.
  def self.configure(&block)
    yield configuration
  end

  ##
  # Returns an existing or instantiates a new configuration object.
  def self.configuration
    @configuration ||= Util::Configuration.new
  end

  private_class_method :configuration
end
