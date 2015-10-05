require "active_model"

module Zoho
  module Subscriptions
    class ResourceBase
      include ActiveModel::Model
      include ActiveSupport::Configurable

      config_accessor :resource_name

      class << self
        def inherited(resource)
          resource.configure do |config|
            config.resource_name = resource.name.gsub("Zoho::Subscriptions::", "").underscore
          end
        end

        def resource_attributes(*attribute_names)
          @attribute_names = attribute_names
          attr_accessor *attribute_names
        end

        def all(filter = {})
          response = Client.get "/#{pluralized_resource_name}", query: filter

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
          custom_request :put, "#{resource_path}/#{id}", body: attributes.to_json
        end

        def destroy(id)
          response = Client.delete "#{resource_path}/#{id}"

          unexpected_response response unless response.code == 200
        end

        def resource_path
          "/#{pluralized_resource_name}"
        end

        def resource_id
          :"#{resource_name}_id"
        end

        def custom_request(http_method, api_path, http_options)
          response = Client.send http_method, api_path, http_options

          case response.code
          when 200, 201
            response[resource_name].slice(*attribute_names.map(&:to_s))
          else
            unexpected_response response
          end
        end

        def custom_action(action_name, http_method:, send_params_through: :body)
          unless [:get, :post, :put, :delete].include? http_method
            raise ArgumentError, "unsupported HTTP method: #{http_method}"
          end

          unless [:query, :body].include? send_params_through
            raise ArgumentError, "unsupported params method: #{send_params_through}"
          end

          define_method action_name do |**params|
            formatted_params = if send_params_through == :body
                                 params.to_json
                               else
                                 params
                               end

            new_attributes = custom_request http_method,
                                            "#{resource_path}/#{action_name}",
                                            send_params_through => formatted_params

            new_attributes.each do |attribute_name, value|
              public_send "#{attribute_name}=", value
            end
          end
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
            raise Errors::Error, "unexpected response code: #{response.code}"
          end
        end

        private

        attr_reader :attribute_names

        def pluralized_resource_name
          resource_name.pluralize
        end
      end

      delegate :resource_id, :custom_request, to: :"self.class"

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

      def resource_path
        "#{self.class.resource_path}/#{id}"
      end
    end
  end
end
