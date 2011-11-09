module  Tumblr 
  module Error
    class TumblrError < StandardError 
      attr_reader :data

      def initialize(data)
        @data = data
        super
      end
    end
    
    class MissingRequiredParameterError < TumblrError; end;
    class NotFoundError < TumblrError; end;
    class BadRequestError < TumblrError; end;
    class UnauthorizedError < TumblrError; end;
    class ForbiddenError < TumblrError; end;
    class InternalServerError < TumblrError; end;
    class BadGatewayError < TumblrError; end;
    class ServiceUnavailableError < TumblrError; end;
  end
end
