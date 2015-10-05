require "spec_helper"

describe Zoho::Subscriptions::Customer do
  subject(:customer) { described_class.find id }

  describe ".all" do
    let(:all_customers) { described_class.all }

    example {
      expect(all_customers.count).to eq 2
      expect(all_customers.first).to be_a Zoho::Subscriptions::Customer
      expect(all_customers.last).to be_a Zoho::Subscriptions::Customer
    }
  end

  describe ".find" do
    context "when the customer exists" do
      let(:id) { 187955000000050049 }
      let(:expected_customer) { described_class.new id: "187955000000050049" }

      it { expect(described_class.find id).to eq expected_customer }
    end

    context "when the customer could not be found" do
      let(:id) { 0 }

      it { expect { described_class.find id }.to raise_error Zoho::Subscriptions::Errors::NotFound }
    end
  end

  describe ".create" do
    let(:new_customer_details) {
      {
        display_name: "John Doe",
        email: "john@doe.com"
      }
    }

    it { expect(described_class.create new_customer_details).to be_a Zoho::Subscriptions::Customer }
  end

  describe "#update" do
    let(:id) { 187955000000050001 }
    let(:customer) { described_class.find id }

    it {
      expect { customer.update display_name: "Jane Doe" }.to(
        change(customer, :display_name).from("John Doe").to("Jane Doe")
      )
    }
  end

  describe "#destroy" do
    let(:id) { 187955000000050083 }
    let(:customer) { described_class.find id }

    before { customer.destroy }

    it { expect { described_class.find id }.to raise_error Zoho::Subscriptions::Errors::NotFound }
  end
end
