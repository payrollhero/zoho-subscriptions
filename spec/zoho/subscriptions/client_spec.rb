require "spec_helper"

describe Zoho::Subscriptions::Client do
  subject(:client) { described_class }

  before do
    client.configure auth_token: "eb4cb816a2ec612f208f13d77086aa25",
                     organization_id: "59183978"
  end

  example { expect(client.get "/organizations").to eq "" }
end
