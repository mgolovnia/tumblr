$:.unshift File.expand_path('../../lib', __FILE__)

require 'tumblr'
require 'rspec'
require 'webmock/rspec'

CONSUMER_KEY = 'consumer_key'
CONSUMER_SECRET = 'consumer_secret'
OAUTH_TOKEN = 'oauth_token'
OAUTH_TOKEN_SECRET = 'oauth_token_secret'

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

RSpec.configure do |config|
  config.mock_with :mocha
end

