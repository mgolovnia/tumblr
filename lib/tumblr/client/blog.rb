require 'rack'
require 'oauth'

module Tumblr
  class Client
    module Blog
       
      def blog_info(params={})
        check_required_params %w(base-hostname), params
        params.merge!("api_key" => consumer_key)
        get build_query("/#{API_VERSION}/blog/#{params.delete("base-hostname")}/info", params) 
      end

      def avatar(params={})
        check_required_params %w(base-hostname), params
        get "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/avatar/#{params.delete("size")}", 
      end

      def followers(params={})
        check_required_params %w(base-hostname), params
        get build_query("/#{API_VERSION}/blog/#{params.delete("base-hostname")}/followers", params)
      end

      def posts(params={})
        check_required_params %w(base-hostname), params
        params.merge!("api_key" => consumer_key)
        get build_query("/#{API_VERSION}/blog/#{params.delete("base-hostname")}/posts/#{params.delete("type")}",params)
      end

      def queue(params={})
        check_required_params %w(base-hostname), params
        get "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/posts/queue"
      end

      def drafts(params={})
        check_required_params %w(base-hostname), params
        get "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/posts/draft"
      end
      
      def submissions(params={})
        check_required_params %w(base-hostname), params
        get "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/posts/submission"
      end
      
      def text(params={})
        check_required_params %w(base-hostname body), params
        params.merge!({"type" => "text"})
        post "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/post", params
      end

      def photo(params={})
        check_required_params %w(base-hostname), params
        params.merge!({"type" => "photo"})
        raise Tumblr::Error::MissingRequiredParameterError unless params.has_key?("source") || params.has_key?("data[]")
        params["data[]"] = OAuth::Helper.escape(File.open(params["data[]"]).binmode.read) if params.has_key?("data[]")
        post "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/post", params
      end

      def quote(params={})
        check_required_params %w(base-hostname quote), params
        params.merge!({"type" => "quote"})
        post "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/post", params
      end

      def link(params={})
        check_required_params %w(base-hostname url), params
        params.merge!({"type" => "link"})

        post "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/post", params
      end

      def chat(params={})
        check_required_params %w(base-hostname conversation), params
        params.merge!({"type" => "chat"})
        post "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/post", params
      end

      def audio(params={})
        check_required_params %w(base-hostname), params
        raise Tumblr::Error::MissingRequiredParameterError.new unless params.has_key?("external_url") || params.has_key?("data[]")
        params.merge!({"type" => "audio"})
        params["data[]"] = OAuth::Helper.escape(File.open(params["data[]"]).binmode.read) if params.has_key?("data[]")
        post "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/post", params
      end

      def video(params={})
        check_required_params %w(base-hostname), params
        raise Tumblr::Error::MissingRequiredParameterError unless params.has_key?("embed") || params.has_key?("data[]")
        params.merge!({"type" => "video"})
        params["data[]"] = OAuth::Helper.escape(File.open(params["data[]"]).binmode.read) if params.has_key?("data[]")
        post "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/post", params
      end

      def edit(params={})
        check_required_params %w(base-hostname id), params
        post "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/post/edit"
      end

      def reblog(params={})
        check_required_params %w(base-hostname id reblog_key), params
        post "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/post/reblog"
      end

      def delete_post(params={})
        check_required_params %w(base-hostname id), params
        post "/#{API_VERSION}/blog/#{params.delete("base-hostname")}/post/delete"
      end

      private

      def check_required_params required_params, params
        required_params.each do |p|
          raise Tumblr::Error::MissingRequiredParameterError.new("Missing required parameter: #{p}") unless params.has_key? p 
        end
      end          

      def build_query(base, params={})
        return base if params.empty?
        "#{base}?#{Rack::Utils.build_query(params)}"
      end
      
    end
  end
end
