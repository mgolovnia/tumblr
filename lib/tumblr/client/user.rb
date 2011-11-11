module Tumblr
  class Client
    module User
      def user_info
        get "/#{API_VERSION}/user/info" 
      end
      
      def dashboard(params={})
        get "/#{API_VERSION}/user/dashboard", params 
      end
      
      def likes(params={})
        get "/#{API_VERSION}/user/likes", params 
      end
      
      def following(params={})
        get "/#{API_VERSION}/user/following", params 
      end

      def follow(url)
        post "/#{API_VERSION}/user/follow", {"url" => url}
      end 

      def unfollow(url)
        post "/#{API_VERSION}/user/unfollow", {"url" => url}
      end 
      
      def like(id, reblog_key)
        post "/#{API_VERSION}/user/like", {"id" => id, "reblog_key" => reblog_key}
      end 
      
      def unlike(id, reblog_key)
        post "/#{API_VERSION}/user/unlike", {"id" => id, "reblog_key" => reblog_key}
      end 
    end
  end
end
