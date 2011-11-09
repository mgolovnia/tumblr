require 'spec_helper'

describe Tumblr::Request do
  
  let(:client) { Tumblr::Client.new }
  
  describe "#get" do
  
    it "should call make_request " do 
      client.stubs(:make_request).returns('')
      client.expects(:make_request).with(:get,'/blog/test.tumblr.com/info').returns('')
      client.get('/blog/test.tumblr.com/info')
    end
  end

  describe "#post" do
  
    it "should call make_request " do 
      client.stubs(:make_request).returns('')
      client.expects(:make_request).with(:post,'/blog/test.tumblr.com/info').returns('')
      client.post('/blog/test.tumblr.com/info')
    end
  end
  
  describe "#put" do
  
    it "should call make_request " do 
      client.stubs(:make_request).returns('')
      client.expects(:make_request).with(:put,'/blog/test.tumblr.com/info').returns('')
      client.put('/blog/test.tumblr.com/info')
    end
  end
  
  describe "#delete" do
  
    it "should call make_request " do 
      client.stubs(:make_request).returns('')
      client.expects(:make_request).with(:delete,'/blog/test.tumblr.com/info').returns('')
      client.delete('/blog/test.tumblr.com/info')
    end
  end

  describe "#make_request" do

    context "error code was returned" do

      context "400" do

        before do
          stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/info*/).to_return(:status => 400, :body => '', :headers => {})
        end
        subject { client }
        it { expect{client.get("/#{Tumblr::API_VERSION}/blog/test.tumblr.com/info")}.to raise_error(Tumblr::Error::BadRequestError)}
      end
      
      context "401" do

        before do
          stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/info*/).to_return(:status => 401, :body => '', :headers => {})
        end
        subject { client }
        it { expect{client.get("/#{Tumblr::API_VERSION}/blog/test.tumblr.com/info")}.to raise_error(Tumblr::Error::UnauthorizedError)}
      end
     
      context "403" do
     
        before do
          stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/info*/).to_return(:status => 403, :body => '', :headers => {})
        end
        subject { client }
        it { expect{client.get("/#{Tumblr::API_VERSION}/blog/test.tumblr.com/info")}.to raise_error(Tumblr::Error::ForbiddenError)}
      end
     
      context "404" do

        before do
          stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/info*/).to_return(:status => 404, :body => '', :headers => {})
        end
        subject { client }
        it { expect{client.get("/#{Tumblr::API_VERSION}/blog/test.tumblr.com/info")}.to raise_error(Tumblr::Error::NotFoundError)}
      end
      
      context "500" do
      
        before do
          stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/info*/).to_return(:status => 500, :body => '', :headers => {})
        end
        subject { client }
        it { expect{client.get("/#{Tumblr::API_VERSION}/blog/test.tumblr.com/info")}.to raise_error(Tumblr::Error::InternalServerError)}
      end
      
      context "502" do
      
        before do
          stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/info*/).to_return(:status => 502, :body => '', :headers => {})
        end
        subject { client }
        it { expect{client.get("/#{Tumblr::API_VERSION}/blog/test.tumblr.com/info")}.to raise_error(Tumblr::Error::BadGatewayError)}
      end
      
      context "503" do
      
        before do
          stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/info*/).to_return(:status => 503, :body => '', :headers => {})
        end
        subject { client }
        it { expect{client.get("/#{Tumblr::API_VERSION}/blog/test.tumblr.com/info")}.to raise_error(Tumblr::Error::ServiceUnavailableError)}
      end
    end
  end
end
