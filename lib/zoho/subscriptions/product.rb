module Zoho
  module Subscriptions
    class Product < ResourceBase
      resource_attributes :product_id,
                          :name,
                          :description,
                          :email_ids,
                          :status,
                          :created_time,
                          :updated_time
    end
  end
end
