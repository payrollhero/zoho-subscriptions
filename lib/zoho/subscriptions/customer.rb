module Zoho
  module Subscriptions
    class Customer < ResourceBase
      configure do |config|
        config.resource_name = "customer"
      end

      resource_attributes :customer_id,
                          :display_name,
                          :first_name,
                          :last_name,
                          :email,
                          :company_name,
                          :phone,
                          :mobile,
                          :website,
                          :billing_address,
                          :shipping_address,
                          :currency_code,
                          :currency_symbol,
                          :currency_id,
                          :price_precision,
                          :unused_credits,
                          :balance,
                          :outstanding,
                          :notes,
                          :status,
                          :custom_fields,
                          :zcrm_account_id,
                          :zcrm_contact_id,
                          :updated_time,
                          :created_time

      alias :id :customer_id
    end
  end
end
