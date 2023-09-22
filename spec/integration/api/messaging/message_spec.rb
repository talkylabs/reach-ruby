require 'spec_helper.rb'

describe 'MessageItem' do

  it "receives create responses" do
    @holodeck.mock(Reach::Response.new(
        201,
      %q[
      {
        "appletId": "AIDXXXXXXXXXXXX",
        "apiVersion": "1.0.0",
        "body": "Hello World! This is a sms message.",
        "dest": "+237671234567",
        "src": "+237691234567",
        "bulkId": null,
        "numSegments": 1,
        "numMedia": 0,
        "price": null,
        "priceUnit": null,
        "messageId": "MIDXXXXXXXXXXXX",
        "status": "sent",
        "messageType": "outbound",
        "errorCode": null,
        "errorMessage": null,
        "dateCreated": "2016-08-29T09:12:33.001Z",
        "dateSent": "2016-08-29T09:12:35.001Z",
        "dateUpdated": "2016-08-29T09:12:35.001Z"
      }
      ]
    ))

    actual = @client.api.messaging \
                       .messaging_items.dispatch(dest: '+237671234567',  src: '+237691234567', body: 'Hello World! This is a sms message.')

    expect(actual).to_not eq(nil)
  end

  
  it "receives create_scheduled_message_sms responses" do
    @holodeck.mock(Reach::Response.new(
        201,
      %q[
      {
        "appletId": "AIDXXXXXXXXXXXX",
        "apiVersion": "1.0.0",
        "body": "Hello World! This is a sms message.",
        "dest": "+237671234567",
        "src": "+237691234567",
        "bulkId": null,
        "numSegments": 1,
        "numMedia": 0,
        "price": null,
        "priceUnit": null,
        "messageId": "MIDXXXXXXXXXXXX",
        "status": "scheduled",
        "messageType": "outbound",
        "errorCode": null,
        "errorMessage": null,
        "dateCreated": "2016-08-29T09:12:33.001Z",
        "dateSent": null,
        "dateUpdated": "2016-08-29T09:12:33.001Z"
      }
      ]
    ))

    actual = @client.api.messaging \
                       .messaging_items.dispatch(dest: '+15558675310',  src: '+237691234567', body: 'Hello World! This is a sms message.')

    expect(actual).to_not eq(nil)
  end


  
end