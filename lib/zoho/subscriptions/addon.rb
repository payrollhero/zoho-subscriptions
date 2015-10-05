module Zoho
  module Subscriptions
    class Addon < ResourceBase
      resource_attributes :addon_code,
                          :name,
                          :unit_name,
                          :pricing_scheme,
                          :price_brackets,
                          :type,
                          :interval_unit,
                          :plans,
                          :status,
                          :product_id,
                          :description,
                          :tax_id,
                          :updated_time,
                          :created_time

      alias :id :addon_code
      alias :id= :addon_code=
    end
  end
end
