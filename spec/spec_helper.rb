$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'zoho/subscriptions'
# require 'webmock/rspec'

Zoho::Subscriptions::Client.configure auth_token: "6526d398ea6184670ceb588703711368",
                                      organization_id: "22563c1a1e7cd2dae0e41636cd2931a5"
