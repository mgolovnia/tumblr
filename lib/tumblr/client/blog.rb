require 'oauth'

module Tumblr
  class Client
    module Blog
       
      def blog_info(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/info", params.merge!("api_key" => consumer_key)
      end

      def avatar(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/avatar/#{params.delete("size")}", params 
      end

      def followers(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/followers", params
      end

      def posts(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/posts/#{params.delete("type")}", params.merge!("api_key" => consumer_key)
      end

      def queue(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/posts/queue", params
      end

      def drafts(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/posts/draft", params
      end
      
      def submissions(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/posts/submission", params
      end
      
      def text(base_hostname, body, params={})
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params.merge!({"body" => body, "type" => "text"})
      end

      def photo(base_hostname,source = nil, data=[], params={})
        params["type"] = "photo"
        params["source"] = source if source
        unless data.empty?
          params["data[]"] = data.map{|file|  OAuth::Helper.escape(File.open(file).binmode.read) }
        end
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params
      end

      def quote(base_hostname, quote, params={})
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params.merge!({"type" => "quote", "quote" => quote})
      end

      def link(base_hostname, url, params={})
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params.merge!({"url" => url, "type" => "link"})
      end

      def chat(base_hostname, conversation, params={})
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params.merge!({"converstion" => conversation, "type" => "chat"})
      end

      def audio(base_hostname, external_url=nil, data=[] , params={})

        params["type"] = "audio"
        params["external_url"] = external_url if external_url
        unless data.empty?
          params["data[]"] = data.map{|file|  OAuth::Helper.escape(File.open(file).binmode.read) }
        end

        post "/#{API_VERSION}/blog/#{base_hostname}/post", params
      end

      def video(base_hostname, embed = nil, data = [], params={})
        params["type"] = "video"
        params["embed"] = embed if embed
        unless data.empty?
          params["data[]"] = data.map{|file|  OAuth::Helper.escape(File.open(file).binmode.read) }
        end
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params
      end

      def edit(base_hostname,id , params={})
        post "/#{API_VERSION}/blog/#{base_hostname}/post/edit", params.merge!({"id" => id})
      end

      def reblog(base_hostname, id, reblog_key, params={})
        post "/#{API_VERSION}/blog/#{base_hostname}/post/reblog", params.merge!({"id" => id , "reblog_key" => reblog_key})
      end

      def delete_post(base_hostname, id, params={})
        post "/#{API_VERSION}/blog/#{base_hostname}/post/delete", params.merge!({"id" => id})
      end

      private

      def check_required_params required_params, params
        required_params.each do |p|
          raise Tumblr::Error::MissingRequiredParameterError.new("Missing required parameter: #{p}") unless params.has_key? p 
        end
      end          

    end
  end
end
