require 'spec_helper'

describe 'Version Action Methods' do
  it 'receives fetch responses' do
    @holodeck.mock(
      Reach::Response.new(
        200,
        '{
            "appletId": "abc",
            "messageId": "cde",
            "src":  "+15108675310",
            "dest": "+15107675310",
            "body": "a body"
          }'
      )
    )
    actual = @client.messaging.messaging_items("abc").fetch
    expect(actual).to_not eq(nil)
  end

  it 'can update messages' do
    @holodeck.mock(
      Reach::Response.new(
        200,
        '{
            "appletId": "abc",
            "messageId": "cde",
            "src":  "+15108675310",
            "dest": "+15107675310",
            "body": "a body"
          }'
      )
    )
    actual = @client.messaging.messaging_items("abc").update(body: '')
    expect(actual).to_not eq(nil)
  end

  it 'handles redirect fetch responses' do
    @holodeck.mock(
      Reach::Response.new(
        307,
        '{
          "dateCreated": "Thu, 30 Jul 2015 20:00:00 +0000",
          "dateUpdated": "Thu, 30 Jul 2015 20:00:00 +0000",
          "serviceName": "friendly_name",
          "appletId": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        }'
      )
    )
    actual = @client.authentix.configuration_items('xyz').fetch
    expect(actual).to_not eq(nil)
  end

  describe 'stream' do
    before(:each) do
      @holodeck.mock(
        Reach::Response.new(
          200,
          '{
            "page": 0,
            "totalPages": 3,
            "pageSize": 2,
            "totalMessages": 5,
            "outOfPageRange": false,
            "messages": [{"body": "payload0"}, {"body": "payload1"}]
          }'
        )
      )
      @holodeck.mock(
        Reach::Response.new(
          200,
          '{
            "page": 1,
            "totalPages": 3,
            "pageSize": 2,
            "totalMessages": 5,
            "outOfPageRange": false,
            "messages": [{"body": "payload2"}, {"body": "payload3"}]
          }'
        )
      )
      @holodeck.mock(
        Reach::Response.new(
          200,
          '{
            "page": 2,
            "totalPages": 3,
            "pageSize": 2,
            "totalMessages": 5,
            "outOfPageRange": true,
            "messages": [{"body": "payload4"}]
          }'
        )
      )
    end

    it 'streams all results' do
      actual = @client.messaging.messaging_items.stream
      expect(actual.count).to eq(5)
    end

    it 'limits results' do
      actual = @client.messaging.messaging_items.stream(limit: 3)
      expect(actual.count).to eq(3)
    end
  end

  it 'receives create responses' do
    @holodeck.mock(
      Reach::Response.new(
        201,
        '{
          "dateCreated": "Thu, 30 Jul 2015 20:00:00 +0000",
          "dateUpdated": "Thu, 30 Jul 2015 20:00:00 +0000",
          "serviceName": "friendly_name",
          "appletId": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        }'
      )
    )
    actual = @client.api.authentix.configuration_items.create(service_name: 'friendly_name')
    expect(actual).to_not eq(nil)
  end

  it 'receives update responses' do
    @holodeck.mock(
      Reach::Response.new(
        200,
        '{
          "dateCreated": "Thu, 30 Jul 2015 20:00:00 +0000",
          "dateUpdated": "Thu, 30 Jul 2015 20:00:00 +0000",
          "serviceName": "friendly_name",
          "appletId": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        }'
      )
    )
    actual = @client.api.authentix.configuration_items('configid').update(service_name: 'friendly_name')
    expect(actual).to_not eq(nil)
  end

  it 'receives read_full responses' do
    @holodeck.mock(
      Reach::Response.new(
        200,
        '{
          "page": 0,
          "totalPages": 1,
          "pageSize": 2,
          "totalConfigurations": 1,
          "outOfPageRange": true,
          "configurations": [
            {
              "dateCreated": "Thu, 30 Jul 2015 20:00:00 +0000",
              "dateUpdated": "Thu, 30 Jul 2015 20:00:00 +0000",
              "serviceName": "friendly_name",
              "appletId": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
            }
          ]
        }'
      )
    )

    actual = @client.api.authentix.configuration_items.list()

    expect(actual).to_not eq(nil)
  end
end
