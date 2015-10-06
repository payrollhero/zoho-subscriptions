# Zoho::Subscriptions

[![Gem Version](https://badge.fury.io/rb/zoho-subscriptions.svg)](http://badge.fury.io/rb/zoho-subscriptions)
[![Code Climate](https://codeclimate.com/github/payrollhero/zoho-subscriptions/badges/gpa.svg)](https://codeclimate.com/github/payrollhero/zoho-subscriptions)
[![Build Status](https://travis-ci.org/payrollhero/zoho-subscriptions.svg)](https://travis-ci.org/payrollhero/zoho-subscriptions)

An API client for Zoho Subscriptions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zoho-subscriptions'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zoho-subscriptions

## Usage

```ruby
# Configuration
Zoho::Subscriptions::Client.configure auth_token: "6526d398ea6184670ceb588703711368",
                                      organization_id: "22563c1a1e7cd2dae0e41636cd2931a5"

# Creating a resource
subscription = Zoho::Subscriptions::Subscription.create customer_id: 187955000000053001,
                                                        auto_collect: false,
                                                        plan: { plan_code: "forever-free", quantity: 1 }
subscription.id # => 187955000000053082

# Retrieving a resource
subscription = Zoho::Subscriptions::Subscription.find 187955000000053082

# Calling custom actions on a resource
subscription.cancel cancel_at_end: false
```

## Supported Resources:
  * [Product](https://www.zoho.com/subscriptions/api/v1/#products)
  * [Plan](https://www.zoho.com/subscriptions/api/v1/#plans)
  * [Addon](https://www.zoho.com/subscriptions/api/v1/#addons)
  * [Customer](https://www.zoho.com/subscriptions/api/v1/#customers)
  * [Subscription (basic resource methods (create, retrieve, update) + cancel)](https://www.zoho.com/subscriptions/api/v1/#subscriptions)

## Resources planned to be supported:
  * [Subscription (more custom actions)](https://www.zoho.com/subscriptions/api/v1/#subscriptions)
  * [Coupon](https://www.zoho.com/subscriptions/api/v1/#coupons)
  * [ContactPerson](https://www.zoho.com/subscriptions/api/v1/#contact-persons)
  * [Invoice](https://www.zoho.com/subscriptions/api/v1/#invoices)
  * [Payment](https://www.zoho.com/subscriptions/api/v1/#payments)
  * [CreditNotes](https://www.zoho.com/subscriptions/api/v1/#credit-notes)
  * [Refund](https://www.zoho.com/subscriptions/api/v1/#refunds)
  * [HostedPage](https://www.zoho.com/subscriptions/api/v1/#hosted-pages)
  * [Event](https://www.zoho.com/subscriptions/api/v1/#events)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/zoho-subscriptions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
