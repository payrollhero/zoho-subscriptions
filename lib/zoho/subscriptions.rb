require "zoho/subscriptions/version"
require "active_support"

module Zoho
  module Subscriptions
    extend ActiveSupport::Autoload

    autoload :Errors
    autoload :Client
    autoload :ResourceBase
    autoload :Customer
    autoload :Subscription
  end
end
