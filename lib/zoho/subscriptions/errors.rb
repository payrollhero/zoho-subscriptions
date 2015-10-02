module Zoho
  module Subscriptions
    module Errors
      # @note: Catch Zoho::Subscriptions::Errors::Error to handle all Zoho::Subscriptions related
      #   errors. Any errors related to the service must inherit Zoho::Subscriptions::Errors::Error.
      class Error < StandardError
      end

      # @note: When the response status is 400
      class BadRequest < Error
      end

      # @note: When the response status is 401
      class Unauthorized < Error
      end

      # @note: When the response status is 404
      class NotFound < Error
      end

      # @note: When the response status is 405
      class MethodNotAllowed < Error
      end

      # @note: When the response status is 429
      class TooManyRequests < Error
      end

      class InternalServerError < Error
      end
    end
  end
end
