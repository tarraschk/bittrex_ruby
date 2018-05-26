# BittrexRuby

This gem provides a wrapper for Bittrex.com Public/Account/Market APIs.

It can for instance place buy/sell orders for you.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bittrex_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bittrex_ruby

## Usage


### Load the gem
```
require 'bittrex_ruby'
```

### Setup your Bittrex API keys

```
BittrexRuby.setup do |config|
  config.key = 'BITTREX_KEY'
  config.secret = 'BITTREX_SECRET'
end
```

### Use the gem

This gem methods are named after the official Bittrex v1.1 API Documentation: https://support.bittrex.com/hc/en-us/articles/115003723911-Developer-s-Guide-API

```
# Public API
BittrexRuby.getmarkets
BittrexRuby.getcurrencies
BittrexRuby.getticker('btc-eth')
BittrexRuby.getmarketsummaries
BittrexRuby.getmarketsummary('btc-eth')
BittrexRuby.getorderbook('btc-eth', 'buy')
BittrexRuby.getmarkethistory('btc-eth')

# Market API
BittrexRuby.buylimit('btc-eth', 1.0, 1.0)
BittrexRuby.selllimit('btc-eth', 1.0, 1.0)
BittrexRuby.cancel('09aa5bb6-8232-41aa-9b78-a5a1093e0211')
BittrexRuby.getopenorders
BittrexRuby.getopenorders('btc-eth')

# Account API
BittrexRuby.getbalances
BittrexRuby.getbalance('BTC')
BittrexRuby.getdepositaddress('BTC')
BittrexRuby.withdraw('EAC', 20.40, 'EAC_ADDRESS')
BittrexRuby.withdraw('EAC', 20.40, 'EAC_ADDRESS', 'PAYMENTID')
BittrexRuby.getorder('0cb4c4e4-bdc7-4e13-8c13-430e587d2cc1')
BittrexRuby.getorderhistory
BittrexRuby.getorderhistory('btc-eth')
BittrexRuby.getwithdrawalhistory
BittrexRuby.getwithdrawalhistory('btc')
BittrexRuby.getdeposithistory
BittrexRuby.getdeposithistory('btc')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tarraschk/bittrex_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the BittrexRuby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tarraschk/bittrex_ruby/blob/master/CODE_OF_CONDUCT.md).
