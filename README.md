# reach-ruby


## Documentation

The documentation for the Reach API can be found [here][apidocs].

The individual releases [here][refdocs].

## Versions

`reach-ruby` uses a modified version of [Semantic Versioning](https://semver.org) for all changes. [See this document](VERSIONS.md) for details.

### Supported Ruby Versions

This library supports the following Ruby implementations:

- Ruby 2.4
- Ruby 2.5
- Ruby 2.6
- Ruby 2.7
- Ruby 3.0
- Ruby 3.1

## Installation

To install using [Bundler][bundler] grab the latest stable version:

```ruby
gem 'reach-ruby', '~> 1.0.0'
```

To manually install `reach-ruby` via [Rubygems][rubygems] simply gem install:

```bash
gem install reach-ruby -v 1.0.0
```

To build and install the development branch yourself from the latest source:

```bash
git clone git@github.com:talkylabs/reach-ruby.git
cd reach-ruby
make install
```

> **Info**
> If the command line gives you an error message that says Permission Denied, try running the above commands with sudo.
>
> For example: `sudo gem install reach-ruby`

### Test your installation

To make sure the installation was successful, try sending yourself an SMS message, like this:

```rb
require "reach-ruby"

# Your API user and key the web app
apiUser = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
apiKey = "your_api_key"

@client = Reach::REST::Client.new apiUser, apiKey
message = @client.messaging.messaging_items.dispatch(
  body: "Hello from Ruby",
  dest: "+12345678901",  # Text this number
  src: "+15005550006", # From a valid number
)

puts message.messageId
```

> **Warning**
> It's okay to hardcode your credentials when testing locally, but you should use environment variables to keep them secret before committing any code or deploying to production.

## Usage

### Authenticate the Client

```ruby
require 'reach-ruby'

# Your API user and key the web app
apiUser = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
apiKey = "your_api_key"

# Initialize the Reach Client with your credentials
@client = Reach::REST::Client.new apiUser, apiKey
```

### Send an SMS

```ruby
@client.messaging.messaging_items.dispatch(
  src: '+14159341234',
  dest: '+16105557069',
  body: 'Hey there!'
)
```

### List your SMS Messages

```ruby
@client.messaging.messaging_items.dispatch.list(limit: 20)
```

### Fetch a single SMS message by messageId

```ruby
# put the message sid you want to retrieve here:
messageId = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
@client.messaging.messaging_items(messageId).fetch
```

### Iterate through records

The library automatically handles paging for you. Collections, such as `messaging_items`, have `list` and stream methods that page under the hood. With both `list` and `stream`, you can specify the number of records you want to receive (`limit`) and the maximum size you want each page fetch to be (`page_size`). The library will then handle the task for you.

`list` eagerly fetches all records and returns them as a list, whereas `stream` returns an enumerator and lazily retrieves pages of records as you iterate over the collection. You can also page manually using the `page` method.


```rb
require 'reach-ruby'

# Your API user and key the web app
apiUser = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
apiKey = "your_api_key"

@client = Reach::REST::Client.new(apiUser, apiKey)

@client.messaging.messaging_items.list
       .each do |msg|
         puts msg.messageId
       end
```

### Enable Debug logging

In order to enable debug logging, pass in a 'logger' instance to the client with the level set to at least 'DEBUG'

```ruby
@client = Reach::REST::Client.new apiUser, apiKey
myLogger = Logger.new(STDOUT)
myLogger.level = Logger::DEBUG
@client.logger = myLogger

@client = Reach::REST::Client.new apiUser, apiKey
myLogger = Logger.new('my_log.log')
myLogger.level = Logger::DEBUG
@client.logger = myLogger
```

### Handle Exceptions {#exceptions}

If the Reach API returns a 400 or a 500 level HTTP response, the `reach-ruby`
library will throw a `Reach::REST::RestError`. 400-level errors are normal
during API operation (`“Invalid number”`, `“Cannot deliver SMS to that number”`,
for example) and should be handled appropriately.

```rb
require 'reach-ruby'

# Your API user and key the web app
apiUser = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
apiKey = "your_api_key"

@client = Reach::REST::Client.new apiUser, apiKey

begin
  messages = @client.messaging.messaging_items.list(limit: 20)
rescue Reach::REST::RestError => e
  puts e.message
end
```

### Debug API requests

To assist with debugging, the library allows you to access the underlying request and response objects. This capability is built into the default HTTP client that ships with the library.

For example, you can retrieve the status code of the last response like so:

```ruby
require 'rubygems' # Not necessary with ruby 1.9 but included for completeness
require 'reach-ruby'

# Your API user and key the web app
apiUser = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
apiKey = "your_api_key"

@client = Reach::REST::Client.new(apiUser, apiKey)

@message = @client.messaging.messaging_items.dispatch(
  dest: '+14158675309',
  src: '+14258675310',
  body: 'Ahoy!'
)

# Retrieve the status code of the last response from the HTTP client
puts @client.http_client.last_response.status_code
```

### Customize your HTTP Client

`reach-ruby` uses [Faraday][faraday] to make HTTP requests. You can tell `Reach::REST::Client` to use any of the Faraday adapters like so:

```ruby
@client.http_client.adapter = :typhoeus
```

To use a custom HTTP client with this helper library, please see the [advanced example of how to do so](./advanced-examples/custom-http-client.md).

To apply customizations such as middleware, you can use the `configure_connection` method like so:

```ruby
@client.http_client.configure_connection do |faraday|
  faraday.use SomeMiddleware
end
```



## Docker Image

The `Dockerfile` present in this repository and its respective `talkylabs/reach-ruby` Docker image are currently used by Us for testing purposes only.

## Getting help

If you've instead found a bug in the library or would like new features added, go ahead and open issues or pull requests against this repo!

[apidocs]: https://www.reach.talkylabs.com/docs/api
[refdocs]: https://talkylabs.github.io/reach-ruby
[wiki]: https://github.com/talkylabs/reach-ruby/wiki
[bundler]: https://bundler.io
[rubygems]: https://rubygems.org
[gem]: https://rubygems.org/gems/talkylabs
[issues]: https://github.com/talkylabs/reach-ruby/issues
[faraday]: https://github.com/lostisland/faraday
