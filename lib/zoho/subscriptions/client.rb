require "httparty"

module Zoho
  module Subscriptions
    class Client
      include HTTParty
      
      class << self
        def configure(auth_token:, organization_id:)
          # auth_token: eb4cb816a2ec612f208f13d77086aa25
          # organization_id: 59183978
          headers "Authorization" => "Zoho-authtoken #{auth_token}"
          headers "X-com-zoho-subscriptions-organizationid" => organization_id
        end
      end
      
      base_uri "https://subscriptions.zoho.com/api/v1"
      format :json
    end
  end
end
