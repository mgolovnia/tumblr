require 'oauth'

module Tumblr
  class Client
    module Blog
       
      def blog_info(base_hostname, params={})
        params.merge!("api_key" => consumer_key)
        get "/#{API_VERSION}/blog/#{base_hostname}/info", params 
      end

      def avatar(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/avatar/#{params.delete("size")}", 
      end

      def followers(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/followers", params
      end

      def posts(base_hostname, params={})
        params.merge!("api_key" => consumer_key)
        get "/#{API_VERSION}/blog/#{base_hostname}/posts/#{params.delete("type")}",params
      end

      def queue(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/posts/queue"
      end

      def drafts(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/posts/draft"
      end
      
      def submissions(base_hostname, params={})
        get "/#{API_VERSION}/blog/#{base_hostname}/posts/submission"
      end
      
      def text(base_hostname, params={})
        check_required_params %w(body), params
        params.merge!({"type" => "text"})
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params
      end

      def photo(base_hostname, params={})
        params.merge!({"type" => "photo"})
        raise Tumblr::Error::MissingRequiredParameterError.new("Missing \"source\" or \"data\" parameter") unless params.has_key?("source") || params.has_key?("data[]")
        params["data[]"] = OAuth::Helper.escape(File.open(base_hostname, params["data[]"]).binmode.read) if params.has_key?("data[]")
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params
      end

      def quote(base_hostname, params={})
        check_required_params %w(quote), params
        params.merge!({"type" => "quote"})
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params
      end

      def link(base_hostname, params={})
        check_required_params %w(url), params
        params.merge!({"type" => "link"})
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params
      end

      def chat(base_hostname, params={})
        check_required_params %w(conversation), params
        params.merge!({"type" => "chat"})
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params
      end

      def audio(base_hostname, params={})
        raise Tumblr::Error::MissingRequiredParameterError.new("Missing \"external_url\" or \"data\" parameter") unless params.has_key?("external_url") || params.has_key?("data[]")
        params.merge!({"type" => "audio"})
        params["data[]"] = OAuth::Helper.escape(File.open(base_hostname, params["data[]"]).binmode.read) if params.has_key?("data[]")
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params
      end

      def video(base_hostname, params={})
        raise Tumblr::Error::MissingRequiredParameterError.new("Missing \"embed\" or \"data\" parameter") unless params.has_key?("embed") || params.has_key?("data[]")
        params.merge!({"type" => "video"})
        params["data[]"] = OAuth::Helper.escape(File.open(base_hostname, params["data[]"]).binmode.read) if params.has_key?("data[]")
        post "/#{API_VERSION}/blog/#{base_hostname}/post", params
      end

      def edit(base_hostname, params={})
        check_required_params %w(id), params
        post "/#{API_VERSION}/blog/#{base_hostname}/post/edit", params
      end

      def reblog(base_hostname, params={})
        check_required_params %w(id reblog_key), params
        post "/#{API_VERSION}/blog/#{base_hostname}/post/reblog", params
      end

      def delete_post(base_hostname, params={})
        check_required_params %w( id), params
        post "/#{API_VERSION}/blog/#{base_hostname}/post/delete", params
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
