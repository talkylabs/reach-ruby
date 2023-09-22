# examples version

@username = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
@auth_token = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
# set up a client
@client = Reach::REST::Client.new(@username, @auth_token)

################ SMS MESSAGES ################

@client.messaging.messaging_items.list(sent_at: '2010-09-01').each do |message|
  puts message.dateCreated
end

# print a particular sms message
puts @client.messaging.messaging_items('SMXXXXXXXX').fetch.body

# send an sms
@client.messaging.messaging_items.dispatch(
  src: '+14159341234',
  dest: '+16105557069',
  body: 'Hey there!'
)

