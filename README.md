# Apikit

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apikit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apikit


```ruby
  @client = Apikit::Client.new(endpoint) do |config|
    config.faraday = Faraday.new do |conn|
      conn.request :url_encoded
      # conn.use DebuggerHandler, self
      conn.adapter Faraday.default_adapter
    end
  end

```
## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/apikit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
