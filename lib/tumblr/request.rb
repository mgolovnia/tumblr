require 'hashie/mash'
require 'json'
require 'rack'

module Tumblr
  module Request
  
    def get(path,params={})
      make_request(:get, build_query(path, params))
    end
    
    def post(path, *params)
      make_request(:post, path, *params)
    end

    def put(path)
      make_request(:put, path)
    end

    def delete(path)
      make_request(:delete, path)
    end

    private

    def build_query(base, params={})
      return base if params.empty?
      "#{base}?#{Rack::Utils.build_query(params)}"
    end


    def make_request(method, path, *params)
      response = connection.request(method, path, *params)
      case response.code.to_i
      when 400
        raise Tumblr::Error::BadRequestError.new(response.body)
      when 401
        raise Tumblr::Error::UnauthorizedError.new(response.body)
      when 403
        raise Tumblr::Error::ForbiddenError.new(response.body)
      when 404
        raise Tumblr::Error::NotFoundError.new(response.body)
      when 500
        raise Tumblr::Error::InternalServerError.new(response.body)
      when 502
        raise Tumblr::Error::BadGatewayError.new(response.body)
      when 503
        raise Tumblr::Error::ServiceUnavailableError.new(response.body)
      end

      response["Content-Type"] == "application/json" ? Hashie::Mash.new(JSON::parse(response.body)) : response.body
    end
  end
  
end
