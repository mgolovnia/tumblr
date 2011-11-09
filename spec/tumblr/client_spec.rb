require 'spec_helper'

describe Tumblr::Client do
  context "creating new client" do
    subject do 
      Tumblr::Client.new do |client| 
        client.consumer_key = CONSUMER_KEY 
        client.consumer_secret = CONSUMER_SECRET 
        client.oauth_token = OAUTH_TOKEN
        client.oauth_token_secret = OAUTH_TOKEN_SECRET
      end
    end
    it {should_not be_nil}
    its(:consumer_key){ should == CONSUMER_KEY }
  end
end
