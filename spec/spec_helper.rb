$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'zoho/subscriptions'
require 'webmock/rspec'
require 'support/fake_api'

RSpec.configure do |config|
  config.before(:each) do |example|
    if example.metadata[:record_responses]
      WebMock.allow_net_connect!
    else
      stub_request(:any, /subscriptions\.zoho\.com/).to_rack(FakeApi)
    end
  end

  config.after(:each) do |example|
    FakeApi.request_history.clear
  end

  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true unless meta.key?(:aggregate_failures)
  end
end

Zoho::Subscriptions::Client.configure auth_token: "6526d398ea6184670ceb588703711368",
                                      organization_id: "22563c1a1e7cd2dae0e41636cd2931a5"

def (Zoho::Subscriptions::Client).perform_request(http_method, path, _options, *)
  response = super

  file_path = "tmp/raw_responses/#{path}-#{http_method::METHOD.downcase}-#{response.code}.json"
  FileUtils.mkpath File.dirname(file_path)
  File.write file_path, JSON.pretty_generate(response)

  response
end
