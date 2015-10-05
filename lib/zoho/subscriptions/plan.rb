module Zoho
  module Subscriptions
    class Plan < ResourceBase
      resource_attributes :plan_code,
                          :plan_id,
                          :name,
                          :recurring_price,
                          :interval,
                          :interval_unit,
                          :billing_cycles,
                          :trial_period,
                          :setup_fee,
                          :addons,
                          :product_id,
                          :tax_id,
                          :description,
                          :status,
                          :created_time,
                          :updated_time

      alias :id :plan_code
      alias :id= :plan_code=
    end
  end
end
