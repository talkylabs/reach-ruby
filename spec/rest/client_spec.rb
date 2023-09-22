require 'spec_helper'
require 'logger'

describe Reach::REST::Client do
  context 'configuration' do
    before do
      Reach.configure do |config|
        config.username = 'someSid'
        config.auth_token = 'someToken'
        config.http_client = 'someClient'
        config.logger = 'someLogger'
      end
    end

    it 'uses the global configuration by default' do
      @client = Reach::REST::Client.new
      expect(@client.username).to eq('someSid')
      expect(@client.auth_token).to eq('someToken')
      expect(@client.http_client).to eq('someClient')
      expect(@client.logger).to eq('someLogger')
    end

    it 'uses the arguments over global configuration' do
      @client = Reach::REST::Client.new('myUser', 'myPassword', 'myClient', 'myLogger')
      expect(@client.username).to eq('myUser')
      expect(@client.auth_token).to eq('myPassword')
      expect(@client.http_client).to eq('myClient')
      expect(@client.logger).to eq('myLogger')
    end

    class MyVersion < Reach::REST::Version
      def initialize(domain)
        super
        @version = 'v1'
      end
    end

    class MyDomain < Reach::REST::Domain
      def initialize(client)
        super
        @host = 'reach.talkylabs.com'
        @base_url = 'https://reach.talkylabs.com'
        @port = 443
      end
    end
  end

  context 'validation' do
    before :all do
      Reach.configure do |config|
        config.username = 'someSid'
        config.auth_token = 'someToken'
        config.http_client = 'someClient'
        config.logger = nil
      end
    end


    it 'translates bad request error params' do
      @domain = MyDomain.new(@client)
      @version = MyVersion.new(@domain)
      @error_message = '{
                          "errorCode": 20001,
                          "errorMessage": "Bad request",
                          "more_info": "more_info here",
                          "status": 400,
                          "errorDetails": {
                              "foo":"bar"
                      }}'
      @holodeck.mock Reach::Response.new(400, @error_message)
      expect {
        @version.fetch('GET', 'http://foobar.com')
      }.to raise_error { |error|
        expect(error).to be_a(Reach::REST::RestError)
        expect(error.status_code).to eq(400)
        expect(error.code).to eq(20_001)
        expect(error.details).to eq({ 'foo' => 'bar' })
        expect(error.error_message).to eq('Bad request')
        expect(error.more_info).to eq('more_info here')
      }
    end
  end

  context 'logging' do
    it 'logs the call details' do
      @client.logger = Logger.new(STDOUT)
      @holodeck.mock Reach::Response.new(200, {})
      expect {
        @client.request('host', 'port', 'GET', 'http://foobar.com')
      }.to output(/Host:foobar.com/).to_stdout_from_any_process
    end

    it 'does not log when the logger instance is not passed' do
      @holodeck.mock Reach::Response.new(200, {})
      expect {
        @client.request('host', 'port', 'GET', 'http://foobar.com')
      }.to_not output(/Host:foobar.com/).to_stdout_from_any_process
    end
  end

  describe '#build_uri' do
    before(:all) do
      Reach.configure do |config|
        config.username = 'username'
        config.auth_token = 'password'
      end
    end

    context 'create default client' do
      it "default client" do
        @client = Reach::REST::Client.new
        expect(@client.build_uri('https://api.reach.talkylabs.com')).to eq('https://api.reach.talkylabs.com')
      end
    end
    
  end

  context 'user agent in headers' do
    before do
      @client.http_client = Reach::HTTP::Client.new
      @connection = Faraday::Connection.new
      expect(Faraday).to receive(:new).and_yield(@connection).and_return(@connection)
      allow_any_instance_of(Faraday::Connection).to receive(:send).and_return(double('response', status: 301, body: {}, headers: {}))
    end

    it 'use default user agent format' do
      @client.request('host', 'port', 'GET', 'https://api.reach.talkylabs.com')
      expect(@client.http_client.last_request.headers['User-Agent']).to match %r{^reach-ruby/[0-9.]+(-rc\.[0-9]+)?\s\([\w-]+\s\w+\)\sRuby/[^\s]+$}
    end

    it 'add user agent extensions' do
      extensions = ['reach-run/2.0.0-test', 'flex-plugin/3.4.0']
      @client.user_agent_extensions = extensions
      @client.request('host', 'port', 'GET', 'https://api.reach.talkylabs.com')
      actual_extensions = @client.http_client.last_request.headers['User-Agent'].split(/ /).last(extensions.size)
      expect(actual_extensions).to match_array(extensions)
    end
  end
end
