require "spec_helper"

describe Tumblr::Client::Blog do

  let (:client) do
    Tumblr::Client.new do |client| 
        client.consumer_key = CONSUMER_KEY 
        client.consumer_secret = CONSUMER_SECRET 
        client.oauth_token = OAUTH_TOKEN
        client.oauth_token_secret = OAUTH_TOKEN_SECRET
     end
  end
  
  describe "#info" do

    before do
      stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/info*/).to_return(:status => 200, :body => fixture('blog_info.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/info/}.returns('')
        client.blog_info('test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.blog_info('test.tumblr.com') }
      it { should_not be_nil } 
      its("response.blog.name"){should eq("david")}
      its("response.blog.title"){should eq("David's Log")}
    end
  end

  describe "#avatar" do

    before do
      stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/avatar*/).to_return(:status => 301, :body => fixture('avatar.json'), 
                                                                                                      :headers => {"Location" => "http://30.media.tumblr.com/avatar_61d09ab16eb4_16.png", "Content-Type" => "application/json"})
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/avatar/}.returns('')
        client.avatar('test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.avatar('test.tumblr.com') }
      it { should_not be_nil } 
      its("meta.status"){ should eq(301) }
      its("response.avatar_url"){ should eq("http://30.media.tumblr.com/avatar_61d09ab16eb4_16.png") }
    end
  end

  describe "#followers" do

    before do
      stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/followers*/).to_return(:status => 200, :body => fixture('followers.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/followers/}.returns('')
        client.followers('test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.followers('test.tumblr.com') }
      it { should_not be_nil } 
      its("meta.status"){ should eq(200) }
      its("response.users"){ should be_an_instance_of(Array) }
      its("response.users.first.name"){ should eq("david") }
      its("response.users.last.name"){ should eq("ben") }
    end
  end

  describe "#posts" do

    before do
      stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/posts*/).to_return(:status => 200, :body => fixture('posts.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/posts/}.returns('')
        client.posts('test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.posts('test.tumblr.com') }
      it { should_not be_nil } 
      its('response.posts.size') { should eq(2)}
    end
  end

  describe "#queue" do

    before do
      stub_request(:get, "http://api.tumblr.com/v2/blog/test.tumblr.com/posts/queue").to_return(:status => 200, :body => fixture('posts.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/posts\/queue/}.returns('')
        client.queue('test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.queue('test.tumblr.com') }
      it { should_not be_nil } 
      its('response.posts.size') { should eq(2)}
    end
  end

  describe "#drafts" do

    before do
      stub_request(:get, "http://api.tumblr.com/v2/blog/test.tumblr.com/posts/draft").to_return(:status => 200, :body => fixture('posts.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/posts\/draft/}.returns('')
        client.drafts('test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.drafts('test.tumblr.com') }
      it { should_not be_nil } 
      its('response.posts.size') { should eq(2)}
    end
  end

  describe "#submissions" do

    before do
      stub_request(:get, "http://api.tumblr.com/v2/blog/test.tumblr.com/posts/submission").to_return(:status => 200, :body => fixture('posts.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/posts\/submission/}.returns('')
        client.submissions('test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.submissions('test.tumblr.com') }
      it { should_not be_nil } 
      its('response.posts.size') { should eq(2)}
    end
  end
  
  describe "#text" do
    
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.text('test.tumblr.com', "body" => "test")
      end
    end

  end

  describe "#photo" do
    
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.photo('test.tumblr.com', "source" => "http://test.com/image.jpg")
      end
    end

  end

  describe "#quote" do
  
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.quote('test.tumblr.com', "Test")
      end
    end
  end

  describe "#link" do

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.link('test.tumblr.com', "url" => "Test")
      end
    end

  end
  
  describe "#chat" do
    
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.chat('test.tumblr.com', "conversation" => "Test")
      end
    end
  end

  describe "#audio" do
  
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.audio('test.tumblr.com',  "http://test.com/test.mp3")
      end
    end

  end

  describe "#video" do

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.video('test.tumblr.com', "embed")
      end
    end

  end

  describe "#edit" do
    
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/post\/edit/}.returns('')
        client.edit('test.tumblr.com', 123)
      end
    end
    
  end

  describe "#reblog" do
  
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/post\/reblog/}.returns('')
        client.reblog('test.tumblr.com', "123", 456)
      end
    end

  end

  describe "#delete_post" do

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |url| url =~ /\/blog\/test\.tumblr\.com\/post\/delete/}.returns('')
        client.delete_post('test.tumblr.com', "id" => "456")
      end
    end

  end



end
