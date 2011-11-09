require 'oauth'

module Tumblr
  module Connection
    private

    def connection
      @consumer ||= OAuth::Consumer.new consumer_key,  consumer_secret,  :site => API_ENDPOINT 
      @access_token ||= OAuth::AccessToken.new(@consumer, oauth_token, oauth_token_secret)
    end
  end
end
