if RUBY_VERSION.start_with?('3.0')
  require 'simplecov'
  require 'simplecov_json_formatter'
  SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
  SimpleCov.start
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'bundler'
Bundler.setup

Dir.glob(File.expand_path('../support/**/*.rb', __FILE__)).sort.each(&method(:require))

require_relative './holodeck/holodeck.rb'
require_relative './holodeck/hologram.rb'

require 'rack'
require 'reach-ruby'
require 'rspec/matchers'
require 'equivalent-xml'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    @client = Reach::REST::Client.new('XX' + 'a' * 32, 'AUTHTOKEN')
    @holodeck = Holodeck.new
    @client.http_client = @holodeck
  end
end

def username
  ENV['USERMAME']
end

def auth_token
  ENV['AUTH_TOKEN']
end

def parse(response)
  Nokogiri::XML::Document.parse(response.to_s, &:noblanks)
end
