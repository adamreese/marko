# Marko

Marketo REST API client with mock support

This gem is still in early development.  Not for production use.

## Installation

Add this line to your application's Gemfile:

    gem 'marko'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install marko

## Usage

### Defaults

Default credentials will be read in from `~/.marketo` file in YAML format.

```yaml
---
:url: https://123-MTH-456.mktorest.com
:client_id: 16fcdb35-79b8-48a1-95a3-a2487aef2d6d
:client_secret: 9df46202bcb74a955323f9e02ad5df96
```

### Creating the client

```ruby
Marko::Client.new(url: "https://123-MTH-456.mktorest.com", client_id: "16fcdb35-79b8-48a1-95a3-a2487aef2d6d", client_secret: "9df46202bcb74a955323f9e02ad5df96")
=> #<Marko::Client::Real:0x007f99da1f9430 @url="https://123-MTH-456.mktorest.com", @api_version="v1", …>
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/marko/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
