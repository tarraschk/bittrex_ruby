
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bittrex_ruby/version'

Gem::Specification.new do |spec|
  spec.name = 'bittrex_ruby'
  spec.version = BittrexRuby::VERSION
  spec.authors = ['Maxime Alay-Eddine']
  spec.email = ['maxime.alayeddine@gmail.com']

  spec.summary = ''"
  Provides a wrapper for Bittrex.com Public/Account/Market APIs.
  "''
  spec.description = ''"
  Provides a wrapper for Bittrex.com Public/Account/Market APIs.
  Supports placing buy/sell orders.
  "''
  spec.homepage = 'https://github.com/tarraschk/bittrex_ruby'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'addressable'
  spec.add_dependency 'json'
  spec.add_dependency 'openssl'
  spec.add_dependency 'rest-client'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
end
