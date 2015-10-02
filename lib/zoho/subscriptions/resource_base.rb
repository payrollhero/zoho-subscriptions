require "active_model"

module Zoho
  module Subscriptions
    class ResourceBase
      include ActiveModel::Model
      include ActiveSupport::Configurable

      config_accessor :resource_name

      class << self
        def resource_attributes(*attribute_names)
          @attribute_names = attribute_names
          attr_accessor *attribute_names
        end

        def all
          response = Client.get "/#{pluralized_resource_name}"

          case response.code
          when 200
            response[pluralized_resource_name].map { |attributes| new attributes.slice(*attribute_names.map(&:to_s)) }
          else
            unexpected_response response
          end
        end

        def find(id)
          response = Client.get "#{resource_path}/#{id}"

          case response.code
          when 200
            new response[resource_name].slice(*attribute_names.map(&:to_s))
          when 404, 400 # Could be a bug in the API but currently when not found the response code is 400
            raise Errors::NotFound, "cannot find #{resource_name} with id:#{id} "
          else
            unexpected_response response
          end
        end

        def create(attributes)
          response = Client.post resource_path, body: attributes.to_json

          case response.code
          when 201
            new response[resource_name].slice(*attribute_names.map(&:to_s))
          else
            unexpected_response response
          end
        end

        def update(id, attributes)
          response = Client.put "#{resource_path}/#{id}", body: attributes.to_json

          case response.code
          when 200
            response[resource_name].slice(*attribute_names.map(&:to_s))
          else
            unexpected_response response
          end
        end

        def destroy(id)
          response = Client.delete "#{resource_path}/#{id}"

          unexpected_response response unless response.code == 200
        end

        def resource_id
          :"#{resource_name}_id"
        end

        private

        attr_reader :attribute_names

        def resource_path
          "/#{pluralized_resource_name}"
        end

        def pluralized_resource_name
          resource_name.pluralize
        end

        def unexpected_response(response)
          case response.code
          when 400
            raise Errors::BadRequest, response["message"]
          when 401
            raise Errors::Unauthorized, response["message"]
          when 405
            raise Errors::MethodNotAllowed, response["message"]
          when 429
            raise Errors::TooManyRequests, response["message"]
          when 500
            raise Errors::InternalServerError
          else
            raise Errors::Error, "unexpected response code: #{code}"
          end
        end
      end

      delegate :resource_id, to: :"self.class"

      def id
        public_send resource_id
      end

      def id=(new_id)
        public_send "#{resource_id}=", new_id
      end

      def ==(other)
        super || other.instance_of?(self.class) && !id.nil? && other.id == id
      end
      alias :eql? :==

      def update(attributes)
        new_attributes = self.class.update id, attributes

        new_attributes.each do |attribute_name, value|
          public_send "#{attribute_name}=", value
        end
      end

      def destroy
        self.class.destroy id
      end
    end
  end
end
