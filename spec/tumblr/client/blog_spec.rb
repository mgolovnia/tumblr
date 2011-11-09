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

    context "missing required params" do
      it{ expect {client.blog_info}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/info/}.returns('')
        client.blog_info("base-hostname" => 'test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.blog_info("base-hostname" => 'test.tumblr.com') }
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

    context "missing required params" do
      it{ expect {client.avatar}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/avatar/}.returns('')
        client.avatar("base-hostname" => 'test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.avatar("base-hostname" => 'test.tumblr.com') }
      it { should_not be_nil } 
      its("meta.status"){ should eq(301) }
      its("response.avatar_url"){ should eq("http://30.media.tumblr.com/avatar_61d09ab16eb4_16.png") }
    end
  end

  describe "#followers" do

    before do
      stub_request(:get, /http:\/\/api\.tumblr\.com\/v2\/blog\/test\.tumblr\.com\/followers*/).to_return(:status => 200, :body => fixture('followers.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "missing required params" do
      it{ expect {client.followers}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end
    
    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/followers/}.returns('')
        client.followers("base-hostname" => 'test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.followers("base-hostname" => 'test.tumblr.com') }
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

    context "missing required params" do
      it{ expect {client.posts}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/posts/}.returns('')
        client.posts("base-hostname" => 'test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.posts("base-hostname" => 'test.tumblr.com') }
      it { should_not be_nil } 
      its('response.posts.size') { should eq(2)}
    end
  end

  describe "#queue" do

    before do
      stub_request(:get, "http://api.tumblr.com/v2/blog/test.tumblr.com/posts/queue").to_return(:status => 200, :body => fixture('posts.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "missing required params" do
      it{ expect {client.queue}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/posts\/queue/}.returns('')
        client.queue("base-hostname" => 'test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.queue("base-hostname" => 'test.tumblr.com') }
      it { should_not be_nil } 
      its('response.posts.size') { should eq(2)}
    end
  end

  describe "#drafts" do

    before do
      stub_request(:get, "http://api.tumblr.com/v2/blog/test.tumblr.com/posts/draft").to_return(:status => 200, :body => fixture('posts.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "missing required params" do
      it{ expect {client.drafts}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/posts\/draft/}.returns('')
        client.drafts("base-hostname" => 'test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.drafts("base-hostname" => 'test.tumblr.com') }
      it { should_not be_nil } 
      its('response.posts.size') { should eq(2)}
    end
  end

  describe "#submissions" do

    before do
      stub_request(:get, "http://api.tumblr.com/v2/blog/test.tumblr.com/posts/submission").to_return(:status => 200, :body => fixture('posts.json'), :headers => {"Content-Type" => "application/json"})
    end

    context "missing required params" do
      it{ expect {client.submissions}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:get).returns('')
        client.expects(:get).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/posts\/submission/}.returns('')
        client.submissions("base-hostname" => 'test.tumblr.com')
      end
    end

    context "required params present" do
      subject { client.submissions("base-hostname" => 'test.tumblr.com') }
      it { should_not be_nil } 
      its('response.posts.size') { should eq(2)}
    end
  end
  
  describe "#text" do
    
    context "missing required params" do
      it{ expect {client.text}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.text("base-hostname" => 'test.tumblr.com', "body" => "test")
      end
    end

  end

  describe "#photo" do
    
    context "missing required params" do
      it{ expect {client.photo}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.photo("base-hostname" => 'test.tumblr.com', "source" => "http://test.com/image.jpg")
      end
    end

  end

  describe "#quote" do
  
    context "missing required params" do
      it{ expect {client.quote}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.quote("base-hostname" => 'test.tumblr.com', "quote" => "Test")
      end
    end
  end

  describe "#link" do

    context "missing required params" do
      it{ expect {client.link}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.link("base-hostname" => 'test.tumblr.com', "url" => "Test")
      end
    end

  end
  
  describe "#chat" do
    
    context "missing required params" do
      it{ expect {client.chat}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.chat("base-hostname" => 'test.tumblr.com', "conversation" => "Test")
      end
    end
  end

  describe "#audio" do
  
    context "missing required params" do
      it{ expect {client.audio}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.audio("base-hostname" => 'test.tumblr.com', "external_url" => "http://test.com/test.mp3")
      end
    end

  end

  describe "#video" do

    context "missing required params" do
      it{ expect {client.video}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/post/}.returns('')
        client.video("base-hostname" => 'test.tumblr.com', "embed" => "embed")
      end
    end

  end

  describe "#edit" do
    
    context "missing required params" do
      it{ expect {client.edit}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/post\/edit/}.returns('')
        client.edit("base-hostname" => 'test.tumblr.com', "id" => "123")
      end
    end
    
  end

  describe "#reblog" do
  
    context "missing required params" do
      it{ expect {client.reblog}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/post\/reblog/}.returns('')
        client.reblog("base-hostname" => 'test.tumblr.com', "reblog_key" => "123", "id" => "456")
      end
    end

  end

  describe "#delete_post" do

    context "missing required params" do
      it{ expect {client.delete_post}.to raise_error(Tumblr::Error::MissingRequiredParameterError)}
    end

    context "making request" do
      it "should make request to correct url" do
        client.stubs(:post).returns('')
        client.expects(:post).with{ |arg| arg =~ /\/blog\/test\.tumblr\.com\/post\/delete/}.returns('')
        client.delete_post("base-hostname" => 'test.tumblr.com', "id" => "456")
      end
    end

  end



end
