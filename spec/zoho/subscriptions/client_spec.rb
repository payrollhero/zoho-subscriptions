require "spec_helper"

describe Zoho::Subscriptions::Client do
  subject(:client) { described_class }

  before do
    client.configure auth_token: "6526d398ea6184670ceb588703711368",
                     organization_id: "22563c1a1e7cd2dae0e41636cd2931a5"
  end

  let(:expected_response) { File.read "spec/fixtures/responses/organizations-get-200.json" }

  example { expect(client.get("/organizations").parsed_response).to eq JSON.parse(expected_response) }
end
