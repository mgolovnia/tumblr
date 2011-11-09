#$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'tumblr'
require 'rspec'
require 'webmock/rspec'

CONSUMER_KEY = 'ICCg62Q1tEYQEeVOz1HwQ8KzHQkLHEmuyqomgIFkisENkJfXAE'
CONSUMER_SECRET = 'muIqRF2Z2dKUJcLAVgOlPtL5P7YEYbsB2j1jCmVZPBhM51uAzA'
OAUTH_TOKEN = 'gnvQ4sDIkn3ZOxOvqxcpDJWRcAxB3voln0iSyS9Ki8BrMWd2LE'
OAUTH_TOKEN_SECRET = 'Osn6TwWJfdgpbdKdsy7Tm7NRxIMytf4C73d4OX9N9X07W4Qd9F'

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

RSpec.configure do |config|
  config.mock_with :mocha
end

