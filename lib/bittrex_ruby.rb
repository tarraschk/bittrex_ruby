require 'bittrex_ruby/version'
require 'rest-client'
require 'openssl'
require 'addressable/uri'
require 'deep_symbolize'
require 'json'

# Gem to use Bittrex API
module BittrexRuby
  class << self
      attr_accessor :configuration
  end

  def self.setup
    @configuration ||= Configuration.new
    yield(configuration)
  end

  # Handles the Bittrex API keys
  class Configuration
    attr_accessor :key, :secret

    def initialize
      @key = ''
      @secret = ''
    end
  end

  # Public API
  def self.getmarkets
    get 'public', 'getmarkets'
  end

  def self.getcurrencies
    get 'public', 'getcurrencies'
  end

  def self.getticker(market)
    get 'public', 'getticker', market: market
  end

  def self.getmarketsummaries
    get 'public', 'getmarketsummaries'
  end

  def self.getmarketsummary(market)
    get 'public', 'getmarketsummary', market: market
  end

  def self.getorderbook(market, type)
    get 'public', 'getorderbook', market: market, type: type
  end

  def self.getmarkethistory(market)
    get 'public', 'getmarkethistory', market: market
  end

  # Market API
  def self.buylimit(market, quantity, rate)
    get_signed 'market', 'buylimit', market: market,
                                     quantity: quantity, rate: rate
  end

  def self.selllimit(market, quantity, rate)
    get_signed 'market', 'selllimit', market: market,
                                      quantity: quantity, rate: rate
  end

  def self.cancel(uuid)
    get_signed 'market', 'cancel', uuid: uuid
  end

  def self.getopenorders(market = nil)
    get_signed 'market', 'getopenorders', market: market
  end

  # Account API
  def self.getbalances
    get_signed 'account', 'getbalances'
  end

  def self.getbalance(currency)
    get_signed 'account', 'getbalance', currency: currency
  end

  def self.getdepositaddress(currency)
    get_signed 'account', 'getdepositaddress', currency: currency
  end

  def self.withdraw(currency, quantity, address, paymentid = nil)
    get_signed 'account', 'withdraw',
               currency: currency, quantity: quantity,
               address: address, paymentid: paymentid
  end

  def self.getorder(uuid)
    get_signed 'account', 'getorder', uuid: uuid
  end

  def self.getorderhistory(market = nil)
    get_signed 'account', 'getorderhistory', market: market
  end

  def self.getwithdrawalhistory(currency = nil)
    get_signed 'account', 'getwithdrawalhistory', currency: currency
  end

  def self.getdeposithistory(currency = nil)
    get_signed 'account', 'getdeposithistory', currency: currency
  end

  class << self
      def resource
        RestClient::Resource.new('https://bittrex.com/api/v1.1/')
      end

      def get(api_group, action, params = {})
        res = resource[api_group + '/' + action].get params: params.compact
        res_hash res
      end

      def get_signed(api_group, action, params = {})
        params[:nonce] = Time.now.to_i
        params[:apikey] = configuration.key

        # Build Query parameters string
        params_query = params.compact.map { |k, v| "#{k}=#{v}" }.join('&')
        uri = resource[api_group + '/' + action + '?' + params_query]

        res = uri.get apisign: create_sign(uri)
        res_hash res
      end

      def create_sign(uri)
        OpenSSL::HMAC.hexdigest('sha512', configuration.secret, uri.url)
      end

      def res_hash(res)
        data = JSON.parse(res.body)
        data.extend DeepSymbolizable
        { data: data.deep_symbolize, res: res }
      end
  end
end
