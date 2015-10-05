module Zoho
  module Subscriptions
    class Subscription < ResourceBase
      configure do |config|
        config.resource_name = "subscription"
      end

      resource_attributes :subscription_id,
                          :name,
                          :customer,
                          :contactpersons,
                          :amount,
                          :product_id,
                          :plan,
                          :addons,
                          :coupon,
                          :custom_fields,
                          :trial_starts_at,
                          :trial_ends_at,
                          :activated_at,
                          :reference_id,
                          :currency_code,
                          :currency_symbol,
                          :exchange_rate,
                          :starts_at,
                          :status,
                          :auto_collect,
                          :salesperson_id,
                          :salesperson_name,
                          :card,
                          :child_invoice_id,
                          :interval,
                          :interval_unit,
                          :current_term_starts_at,
                          :current_term_ends_at,
                          :expires_at,
                          :last_billing_at,
                          :next_billing_at,
                          :cancelled_at,
                          :source,
                          :next_retry_at,
                          :notes,
                          :created_time,
                          :updated_time

      alias :id :subscription_id
    end
  end
end
