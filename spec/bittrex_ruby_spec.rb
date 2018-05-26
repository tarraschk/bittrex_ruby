RSpec.describe BittrexRuby do
  context 'GEM ARCH' do
    it 'has a version number' do
      expect(BittrexRuby::VERSION).not_to be nil
    end
  end

  context 'PUBLIC API' do
    it 'runs getmarkets' do
      expect(JSON.parse(BittrexRuby.getmarkets[:res])['success'])
        .to eq(true)
    end

    it 'runs getcurrencies' do
      expect(JSON.parse(BittrexRuby.getcurrencies[:res])['success'])
        .to eq(true)
    end

    it 'runs getticker for btc-eth' do
      expect(JSON.parse(BittrexRuby.getticker('btc-eth')[:res])['success'])
        .to eq(true)
    end

    it 'runs getmarketsummaries' do
      expect(JSON.parse(BittrexRuby.getmarketsummaries[:res])['success'])
        .to eq(true)
    end

    it 'runs getmarketsummary for btc-eth' do
      expect(JSON.parse(BittrexRuby.getmarketsummary('btc-eth')[:res])['success'])
        .to eq(true)
    end

    it 'runs getorderbook for btc-eth buy' do
      expect(JSON.parse(BittrexRuby.getorderbook('btc-eth', 'buy')[:res])['success'])
        .to eq(true)
    end

    it 'runs getmarkethistory' do
      expect(JSON.parse(BittrexRuby.getmarkethistory('btc-eth')[:res])['success'])
        .to eq(true)
    end
  end

  context 'MARKET API' do
    before(:all) do
      # Mockup Bittrex account for Rspec
      BittrexRuby.setup do |config|
        config.key = ENV['BITTREX_KEY']
        config.secret = ENV['BITTREX_SECRET']
      end
    end

    it 'runs buylimit' do
      expect(JSON.parse(BittrexRuby.buylimit('btc-eth', 1.0, 1.0)[:res])['message'])
        .to eq('INSUFFICIENT_FUNDS')
    end

    it 'runs selllimit' do
      expect(JSON.parse(BittrexRuby.selllimit('btc-eth', 1.0, 1.0)[:res])['message'])
        .to eq('INSUFFICIENT_FUNDS')
    end

    it 'runs cancel' do
      expect(JSON.parse(BittrexRuby.cancel('09aa5bb6-8232-41aa-9b78-a5a1093e0211')[:res])['message'])
        .to eq('INVALID_ORDER')
    end

    it 'runs getopenorders with no market' do
      expect(JSON.parse(BittrexRuby.getopenorders[:res])['message'])
        .to eq('')
    end

    it 'runs getopenorders with valid market' do
      expect(JSON.parse(BittrexRuby.getopenorders('btc-eth')[:res])['message'])
        .to eq('')
    end
  end

  context 'ACCOUNT API' do
    before(:all) do
      # Mockup Bittrex account for Rspec
      BittrexRuby.setup do |config|
        config.key = ENV['BITTREX_KEY']
        config.secret = ENV['BITTREX_SECRET']
      end
    end

    it 'runs getbalances' do
      expect(JSON.parse(BittrexRuby.getbalances[:res])['message'])
        .to eq('')
    end

    it 'runs getbalance' do
      expect(JSON.parse(BittrexRuby.getbalance('BTC')[:res])['message'])
        .to eq('')
    end

    it 'runs getdepositaddress' do
      expect(JSON.parse(BittrexRuby.getdepositaddress('BTC')[:res])['message'])
        .to eq('ACCOUNT_NOT_VERIFIED')
    end

    it 'runs withdraw without paymentid' do
      expect(JSON.parse(BittrexRuby.withdraw('EAC', 20.40, 'EAC_ADDRESS')[:res])['message'])
        .to eq('INVALID_PERMISSION')
    end

    it 'runs withdraw with paymentid' do
      expect(JSON.parse(BittrexRuby.withdraw('EAC', 20.40, 'EAC_ADDRESS', 'PAYMENTID')[:res])['message'])
        .to eq('INVALID_PERMISSION')
    end

    it 'runs getorder' do
      expect(JSON.parse(BittrexRuby.getorder('0cb4c4e4-bdc7-4e13-8c13-430e587d2cc1')[:res])['message'])
        .to eq('')
    end

    it 'runs getorderhistory without market' do
      expect(JSON.parse(BittrexRuby.getorderhistory[:res])['message'])
        .to eq('')
    end

    it 'runs getorderhistory with market' do
      expect(JSON.parse(BittrexRuby.getorderhistory('btc-eth')[:res])['message'])
        .to eq('')
    end

    it 'runs getwithdrawalhistory without currency' do
      expect(JSON.parse(BittrexRuby.getwithdrawalhistory[:res])['message'])
        .to eq('')
    end

    it 'runs getwithdrawalhistory with currency' do
      expect(JSON.parse(BittrexRuby.getwithdrawalhistory('btc')[:res])['message'])
        .to eq('')
    end

    it 'runs getdeposithistory without currency' do
      expect(JSON.parse(BittrexRuby.getdeposithistory[:res])['message'])
        .to eq('')
    end

    it 'runs getdeposithistory with currency' do
      expect(JSON.parse(BittrexRuby.getdeposithistory('btc')[:res])['message'])
        .to eq('')
    end
  end
end
