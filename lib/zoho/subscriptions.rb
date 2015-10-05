require "zoho/subscriptions/version"
require "active_support"

module Zoho
  module Subscriptions
    extend ActiveSupport::Autoload

    autoload :Errors
    autoload :Client
    autoload :ResourceBase
    autoload :Product
    autoload :Plan
    autoload :Addon
    autoload :Coupon
    autoload :Customer
    autoload :ContactPerson
    autoload :Subscription
    autoload :Invoice
    autoload :Payment
    autoload :CreditNotes
    autoload :Refund
    autoload :HostedPage
    autoload :Event
  end
end
