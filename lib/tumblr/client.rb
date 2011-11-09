require 'tumblr/error'
require 'tumblr/connection'
require 'tumblr/request'
require 'tumblr/client/blog'
require 'tumblr/client/user'

module Tumblr
  class Client

    attr_accessor :consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret

    def initialize
      yield self if block_given?
    end

    include Tumblr::Error
    include Tumblr::Connection
    include Tumblr::Request
    
    include Tumblr::Client::Blog
    include Tumblr::Client::User
  end
end
