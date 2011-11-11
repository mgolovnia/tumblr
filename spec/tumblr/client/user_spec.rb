require "spec_helper"

describe Tumblr::Client::User do

  let (:client) do
    Tumblr::Client.new do |client| 
        client.consumer_key = CONSUMER_KEY 
        client.consumer_secret = CONSUMER_SECRET 
        client.oauth_token = OAUTH_TOKEN
        client.oauth_token_secret = OAUTH_TOKEN_SECRET
     end
  end
  
  describe "#user_info" do

    before do
      stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/user\/info*/).to_return(:status => 200, :body => fixture('user_info.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |arg| arg =~ /\/user\/info/}.returns('')
        client.user_info
      end
    end

    context "required params present" do
      subject { client.user_info}
      it { should_not be_nil } 
      its("response.user.name"){should eq("derekg")}
    end
  end
  
  describe "#dashboard" do

    before do
      stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/user\/dashboard*/).to_return(:status => 200, :body => fixture('dashboard.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |arg| arg =~ /\/user\/dashboard/}.returns('')
        client.dashboard
      end
    end

    context "required params present" do
      subject { client.dashboard}
      it { should_not be_nil } 
      its("response.posts.size"){should eq(2)}
      its("response.posts.first.blog_name"){should eq("blog1")}
      its("response.posts.last.blog_name"){should eq("blog2")}
    end
  end

  describe "#likes" do

    before do
      stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/user\/likes*/).to_return(:status => 200, :body => fixture('likes.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |arg| arg =~ /\/user\/likes/}.returns('')
        client.likes
      end
    end

    context "required params present" do
      subject { client.likes}
      it { should_not be_nil } 
      its("response.liked_post.size"){should eq(2)}
      its("response.liked_count"){should eq(2)}
      its("response.liked_post.first.blog_name"){should eq("blog1")}
      its("response.liked_post.last.blog_name"){should eq("blog2")}
    end
  end

  describe "#following" do

    before do
      stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/user\/following*/).to_return(:status => 200, :body => fixture('following.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |arg| arg =~ /\/user\/following/}.returns('')
        client.following
      end
    end

    context "required params present" do
      subject { client.following}
      it { should_not be_nil } 
      its("response.blogs.size"){should eq(2)}
      its("response.total_blogs"){should eq(2)}
      its("response.blogs.first.name"){should eq("david")}
      its("response.blogs.last.name"){should eq("matthew")}
    end
  end
  
  describe "#follow" do
    
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/user\/follow/}.returns('')
        client.follow('test.tumblr.com')
      end
    end

  end

  describe "#unfollow" do
    
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/user\/unfollow/}.returns('')
        client.unfollow('test.tumblr.com')
      end
    end

  end

  describe "#like" do
    
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/user\/like/}.returns('')
        client.like('1234567', 'abcdf')
      end
    end

  end

  describe "#unlike" do
    
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/user\/unlike/}.returns('')
        client.unlike('1234567', 'abcdf')
      end
    end

  end
end

