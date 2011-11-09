require 'spec_helper'

describe Tumblr::Connection do
  let(:client) { Tumblr::Client.new }

  describe "#connection" do
    subject { client.send(:connection) }
    it { should be_an_instance_of(OAuth::AccessToken)}
    its('consumer.options.values') { should include(Tumblr::API_ENDPOINT) }
  end
end
